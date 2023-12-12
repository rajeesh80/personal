/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 12-11-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
private class AppleWatchTest {
	//adding a comment to test git commit.
	@isTest static void createOpportunity() {
		Opportunity opp = new Opportunity();
		opp.Name = 'Test';
		opp.StageName = 'Prospecting';
		opp.CloseDate = Date.today()+90;
		insert opp;
	}
	
	
}