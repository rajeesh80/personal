@isTest
private class AppleWatchTest {
	
	@isTest static void createOpportunity() {
		Opportunity opp = new Opportunity();
		opp.Name = 'Test';
		opp.StageName = 'Prospecting';
		opp.CloseDate = Date.today()+90;
		insert opp;
	}
	
	
}