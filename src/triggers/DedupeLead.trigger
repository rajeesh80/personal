trigger DedupeLead on Lead (before insert) {
	//Data Quality group
	List<Group> dataQualityGroups	=	[SELECT Id
								  		   FROM Group 
								          WHERE DeveloperName = 'Data_Quality'];
	for(Lead myLead : Trigger.new) {
		if(myLead.Email != null) {
			List<Contact> matchingContacts = [SELECT Id,
													 FirstName,
													 LastName,
													 Account.Name
												FROM Contact
											   WHERE Email = :myLead.Email];
			System.debug('Matching contact size' + matchingContacts.size()+' contact(s) found');
			if(!matchingContacts.isEmpty()) {
				if(!dataQualityGroups.isEmpty()) {
					myLead.OwnerId		=	dataQualityGroups.get(0).Id;
				}
				String dupeContactMessage	=	'Duplicate contact(s) found \n';
				for(Contact matchingContact : matchingContacts) {
					dupeContactMessage += 	matchingContact.FirstName 	+	' '
										+	matchingContact.LastName	+	' '
										+	matchingContact.Account.Name+	' ('
										+	matchingContact.Id 			+	')\n';
				}
				if(myLead.Description != null) {
					myLead.Description		=	dupeContactMessage+'\n'+ myLead.Description;
				}
				else {
					myLead.Description		=	dupeContactMessage;	
				}

			}										   
		}
	}

}