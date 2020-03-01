var contractAddress = "0x3bab75af79cdf5d2cd50e0e75bf7131585a21c53";


console.log("Interface Contract");
var contract061 = eth.contract([{"inputs":[],"name":"getTotalCandidatos","outputs":[{"internalType":"uint256","name":"total","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"pidCandidato","type":"string"},{"internalType":"uint256","name":"puf","type":"uint256"},{"internalType":"uint256","name":"pcmun","type":"uint256"}],"name":"getTotalVotosPorCandidato","outputs":[{"internalType":"uint256","name":"total","type":"uint256"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"pidBu","type":"string"},{"internalType":"string","name":"pidCandidato","type":"string"},{"internalType":"uint256","name":"puf","type":"uint256"},{"internalType":"uint256","name":"pcmun","type":"uint256"},{"internalType":"uint256","name":"pvoteCount","type":"uint256"}],"name":"vote","outputs":[],"stateMutability":"nonpayable","type":"function"}])

console.log("Execute Vote");
var vote = contract061.at(contractAddress).vote.sendTransaction(1,2,1,1,1,{from: eth.coinbase});
console.log(vote);

console.log("getContract by address");
var getTotalCandidatos = contract061.at(contractAddress).getTotalCandidatos.sendTransaction({from: eth.coinbase});
console.log(getTotalCandidatos);

console.log("filter");

var greeter = Greeter.load(greeterContractAddress, web3j, credentials, gasPrice, gasLimit);
TransactionReceipt transactionReceipt = greeter.changeGreeting(new Utf8String(greetingToWrite)).get(timeout);
String result = "Successful transaction. Gas used: " + transactionReceipt.getGasUsed();
 