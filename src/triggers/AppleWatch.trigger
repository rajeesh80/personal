trigger AppleWatch on Opportunity (after insert){
	for(Opportunity opp: trigger.new){
		Task t 			= 	new Task();
		t.Subject 		= 	'Apple Watch Demo';
		t.Description 	= 	'Send them ASAP';
		t.Priority		=	'High';
		t.WhatId		=	opp.Id;
		insert t;
	}
}