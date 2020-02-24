contract MultipleRecipients {
	address private owner;
	function MultipleRecipients() {
		owner = msg.sender;
	}

	function send(address[] _recipients,uint[] _amounts) public returns(bool) {

		if(msg.sender!=owner) {
			throw;
		}

		for(uint i = 0;i<_recipients.length;i++) {
			uint amount = _amounts[i];
			address sender = _recipients[i];
			sender.send(amount);
		}

		return true;
	}
}