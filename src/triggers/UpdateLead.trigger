trigger UpdateLead on Lead (before update) {
//test trigger
	for(Lead l: Trigger.new){
		l.FirstName = 'Helllo';
		l.LastName	= 'World';
	}
}