public with sharing class PageController {
	public PageController() {
		
	}
	public class MyWrapper {
		public Contact con {get;private set;}
		public Opportunity opp{get;private set;}
		public MyWrapper(Contact c, Opportunity o) {
		this.con = c;
		this.opp = o;
		}
	}
}