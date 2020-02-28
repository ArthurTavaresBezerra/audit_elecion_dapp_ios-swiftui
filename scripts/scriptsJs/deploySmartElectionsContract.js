
var contract = eth.contract([{"constant":true,"inputs":[{"name":"x","type":"uint8"},{"name":"y","type":"uint8"}],"name":"getValue","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}])

var instance = contract.new(bytecode, {from:eth.coinbase, data:bytecode, gas: 2000000});
instance.getvalue(1,2)

var mycarrayContract.at = eth.contract([{"constant":true,"inputs":[{"name":"x","type":"uint8"},{"name":"y","type":"uint8"}],"name":"getValue","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}])

mycarrayContract.at("0x419a042FF81beAD2838D6A506076da7dF3542cF3").getValue(1,1);


Executar do RPC 
https://ethereum.stackexchange.com/questions/8671/using-my-contracts-functions-via-rpc-calls

Deploy e Execute SmartContracts
https://medium.com/@chakrvyuh/prototyping-a-blockchain-smart-contract-78877464e38e

https://remix.ethereum.org/#version=soljson-v0.4.17+commit.bdeb9e52.js&optimize=false



 curl localhost:8545 -X POST --data '{"jsonrpc":"2.0","method":"eth_call","params":[{"from": "0x8aff0a12f3e8d55cc718d36f84e002c335df2f4a", "to": "0x5c7687810ce3eae6cda44d0e6c896245cd4f97c6", "data": "0x6740d36c0000000000000000000000000000000000000000000000000000000000000005"}],"id":1}'
> web3.sha3('getValue(int256,int256)')