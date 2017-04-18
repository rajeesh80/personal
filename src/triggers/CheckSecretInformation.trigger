trigger CheckSecretInformation on Case (after insert, before update) {
	Set<String> secretKeywords = new Set<String>();
	secretKeywords.add('Credit Card');
	secretKeywords.add('Social Security');
	secretKeywords.add('SSN');
	secretKeywords.add('Passport');
	secretKeywords.add('Bodyweight');
	List<Case> casesWithSecretInfo = new List<Case>();
	String childCaseSubject = 'Warning: Parent case may contain secret info';
	for(Case myCase: Trigger.new) {
		if(myCase.subject!=childCaseSubject) {
			for(String keyword: secretKeywords) {
				if(myCase.Description != null && myCase.Description.containsIgnoreCase(keyword)) {
					casesWithSecretInfo.add(myCase);
					System.debug('Case '+myCase.Id+' include secret keyword '+keyword);
					break;	
				}
			}
		}					
	}
	List<Case> childCaseList	=	new List<Case>();
	for(Case caseWithSecretInfo : casesWithSecretInfo) {
		Case childCase			=	new Case();
		childCase.subject		=	childCaseSubject;
		childCase.ParentId		=	caseWithSecretInfo.Id;
		childCase.IsEscalated	=	true;
		childCase.Priority		=	'High';
		childCase.Description	=	'Atleast one of the following key words are present'+secretKeywords;
		childCaseList.add(childCase);
		
	}
	insert childCaseList;
}