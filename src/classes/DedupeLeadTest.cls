@isTest
private class DedupeLeadTest {
	@isTest static void createLeadNoDupes() {
		String leadOwner		=	UserInfo.getUserId();
	
		// Create all required records
		Lead myLead			=	new Lead();
		myLead.FirstName	=	'John';
		myLead.LastName		=	'Doe';
		myLead.Company		=	'Amazon';
		myLead.Email		=	'john.doe@amazon.com';
		myLead.Description	=	'John Doe test dedupe lead';
		myLead.OwnerId		=	leadOwner;
		insert myLead;
	

	//SOQL to find latest values
		Lead updatedLead	=	[SELECT OwnerId,
										Description
								   FROM	Lead
								  WHERE Id = :myLead.Id];

	//System.assertEquals
		System.assertEquals(leadOwner,updatedLead.OwnerId);
		System.assertEquals(myLead.Description, updatedLead.Description);
	}

	@isTest static void createLeadMultipleDupes() {
		// create 2 duplicate contacts
		List<Contact> dupeContacts	=	new List<Contact>();
		Contact firstDupe			=	new	Contact();
		firstDupe.FirstName			=	'John';
		firstDupe.LastName			=	'Doe';
		firstDupe.Email				=	'john.doe@amazon.com';
		dupeContacts.add(firstDupe);
		Contact secondDupe			=	new	Contact();
		secondDupe.FirstName		=	'John';
		secondDupe.LastName			=	'Doe';
		secondDupe.Email			=	'john.doe@amazon.com';
		dupeContacts.add(secondDupe);
		insert dupeContacts;

		//create lead
		Lead myLead					=	new Lead();
		mylead.FirstName			=	'John';
		mylead.LastName				=	'Doe';
		myLead.Company				=	'Amazon';
		myLead.Email				=	'john.doe@amazon.com';
		mylead.OwnerId				=	UserInfo.getUserId();
		myLead.Description			=	'dedupe test lead';
		insert myLead;

		//Get updated field values
		Lead updatedLead			=	[SELECT OwnerId,
												Description
										   FROM Lead
										  WHERE Id = :mylead.Id];	

		//Get the data quality queue
		Group	dataQualityQueue	=	[SELECT Id
										   FROM Group
										  WHERE DeveloperName = 'Data_Quality'
										  LIMIT 1];
		//Assertions
		System.assertEquals(dataQualityQueue.Id, updatedLead.OwnerId);
		System.assert(updatedLead.Description.contains(firstDupe.Id));
		System.assert(updatedLead.Description.contains(secondDupe.Id));
				
	}
	
}