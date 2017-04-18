@isTest
private class ComparableOppsTest {
	
	@isTest static void noComparableOpps() {
		//negative test case
		Account acc 	=	new Account();
		acc.Name		=	'JohnDoeCorp';
		acc.Industry	=	'Hospitality';
		insert acc;

		Opportunity opp =	new Opportunity();
		opp.AccountId	=	acc.Id;
		opp.Name		=	'JohnDoeCorp';
		opp.Amount		=	100;
		opp.StageName	=	'Prospecting';
		opp.CloseDate	=	Date.today()+10;
		insert opp;

		List<Comparable__c> comparables = [SELECT Id
									FROM Comparable__c
									WHERE Base_Opportunity__c = :opp.Id];

		System.assertEquals(0, comparables.size());							

	}
	
	@isTest static void multipleComparableOpps() {
		// Implement test code
		Account acc 	=	new Account();
		acc.Name		=	'JohnDoeCorp';
		acc.Industry	=	'Hospitality';
		insert acc;

		List <Opportunity> comparableOpps = new List<Opportunity>();
		Opportunity cmpOpp1 =	new Opportunity();
		cmpOpp1.AccountId	=	acc.Id;
		cmpOpp1.Name		=	'JohnDoeCorp';
		cmpOpp1.Amount		=	105;
		cmpOpp1.StageName	=	'Closed Won';
		cmpOpp1.CloseDate	=	Date.today()-1;
		//insert opp;
		comparableOpps.add(cmpOpp1);

		Opportunity cmpOpp2 =	new Opportunity();
		cmpOpp2.AccountId	=	acc.Id;
		cmpOpp2.Name		=	'JohnDoeCorp';
		cmpOpp2.Amount		=	102;
		cmpOpp2.StageName	=	'Closed Won';
		cmpOpp2.CloseDate	=	Date.today();
		//insert opp;
		comparableOpps.add(cmpOpp2);
		insert comparableOpps;

		//Base Opportunity
		Opportunity baseOpp =	new Opportunity();
		baseOpp.AccountId	=	acc.Id;
		baseOpp.Name		=	'JohnDoeCorp';
		baseOpp.Amount		=	100;
		baseOpp.StageName	=	'Prosepcting';
		baseOpp.CloseDate	=	Date.today()+10;
		insert baseOpp;

		List<Comparable__c> comparables = [SELECT Id,
												  Comparable_Opportunity__c
											 FROM Comparable__c
											WHERE Base_Opportunity__r.Id = :baseOpp.Id
										 ORDER BY Comparable_Opportunity__r.CloseDate DESC];
		//Assertions
		System.assertEquals(cmpOpp2.Id,comparables.get(0).Comparable_Opportunity__c);
		System.assertEquals(cmpOpp1.Id,comparables.get(1).Comparable_Opportunity__c);
	}
	
}