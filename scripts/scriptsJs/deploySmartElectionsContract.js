var bytecode061 = "0x608060405234801561001057600080fd5b5060c68061001f6000396000f3fe6080604052348015600f57600080fd5b506004361060325760003560e01c80636057361d146037578063b05784b8146062575b600080fd5b606060048036036020811015604b57600080fd5b8101908080359060200190929190505050607e565b005b60686088565b6040518082815260200191505060405180910390f35b8060008190555050565b6000805490509056fea265627a7a723158209e869bf97eba094ccf7533f0f92b4de32cf3cce7d7cff974769bca975e178b0164736f6c63430005110032";
var abi061 = [{"constant":true,"inputs":[],"name":"retreive","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"num","type":"uint256"}],"name":"store","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}]; 

var contractName = "SmartElection061"
console.log("Instanciate the contract");
var deploy = web3.eth.contract(abi061).new(contractName,{from:web3.eth.coinbase, data: bytecode061, gas: 1000000}, function(e, contract){
    if(!e) {
  
      if(!contract.address) {
        console.log("Contract transaction send: TransactionHash: " + contract.transactionHash + " waiting to be mined...");
        
        console.log("Mining", eth.mining);
        var miningBefore = eth.mining;
        if (!miningBefore)
            miner.start(4);
        
        console.log("Mining", eth.mining);
        var count = 0;
        while (count < 20){
            count++;
            console.log( "Esperando minerar: " + count + " Mining: " + eth.mining);
            admin.sleep(2);
            var tran = eth.getTransactionReceipt(contract.transactionHash);
            if (tran && tran.contractAddress) {
                console.log("Contract mined! Address: " + tran.contractAddress);
                break;
            }
        }

        if (!miningBefore)
            miner.stop();
        
        console.log("Mining", eth.mining);

      } else {
        console.log("Contract mined! Address: " + contract.address);
        console.log(contract);
      }
  
    }
    else {
        console.log(e);
    }
  }
)