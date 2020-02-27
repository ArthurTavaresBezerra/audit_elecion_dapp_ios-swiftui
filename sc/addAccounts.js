//if (eth.accounts.length == 0)
personal.importRawKey("008f3b2a0db3863a760081b24459290b912d3ba3e955dd50be57ccc8cb056500","a1") 
    //0x9cf997fd313e4c4c678593428cc65235dc298c6d

//if (eth.accounts.length == 1)
    personal.importRawKey("008f3b2a0db3863a760081b24459290b912d3ba3e955dd50be57ccc8cb056501","a1")
    //0x019b2231c3cd4e4f3115ea69573014702d4cbb23

if (eth.accounts.length == 2)
    personal.newAccount("a1")
