trigger CreateCase on Account (after insert) {
	for(Account a: Trigger.new){
		Case c		=	new Case();
		c.AccountId = 	a.Id;
		c.Status	=	'New';
		c.Origin	=	'Web';
		c.Subject	=	'Dedupe this account';
		c.OwnerId	=	'005460000013MK4';
		insert c;
	}
}