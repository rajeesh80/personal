@isTest
private class CheckSecretInformationTest {
	
	@isTest static void createCaseWithSecretInfo() {
		Case myCase	=	new Case();
		myCase.Subject	=	'Test case';
		myCase.Description	=	'My bodyweight is 190 lbs';
		insert myCase;
		System.debug('Case '+myCase.Id+' created with description '+myCase.Description);
		
	}
	
	
}