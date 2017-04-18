@isTest
private class LeadingCompetitorTest {
	
	@isTest static void createOppWithCompetitors() {
		Opportunity opp = new Opportunity();
		opp.Name = 'Big deal';
		opp.CloseDate = Date.today()+90;
		opp.StageName = 'Prospecting';

		opp.Competitor_1_Price__c=5000;
		opp.Competitor_2_Price__c=10000;
		opp.Competitor_3_Price__c=15000;

		opp.Competitor_1__c = 'Amazon';
		opp.Competitor_2__c = 'Google';
		opp.Competitor_3__c = 'Yahoo';

		insert opp;
		System.debug('Opportunity '+opp.Name+' inserted with competitor info');
	}

}