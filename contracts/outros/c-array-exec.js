 
var carrayContract = web3.eth.contract([{"constant":true,"inputs":[{"name":"x","type":"uint8"},{"name":"y","type":"uint8"}],"name":"getValue","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]);
var carray = carrayContract.new( 
   {
     from: web3.eth.accounts[0], 
     data: '0x60806040526000805460a060020a60ff021916740a000000000000000000000000000000000000000017905534801561003757600080fd5b5060008054600160a060020a03191633600160a060020a0316178155805b60005460ff740100000000000000000000000000000000000000009091048116908216101561012457600091505b60005460ff740100000000000000000000000000000000000000009091048116908316101561011c5760005460ff74010000000000000000000000000000000000000000909104811682028301906001908416600a81106100e057fe5b0160ff8316600a81106100ef57fe5b602091828204019190066101000a81548160ff021916908360ff1602179055508180600101925050610083565b600101610055565b505061014a806101356000396000f30060806040526004361061004b5763ffffffff7c01000000000000000000000000000000000000000000000000000000006000350416630e13b9af811461005057806341c0e1b514610087575b600080fd5b34801561005c57600080fd5b5061007160ff6004358116906024351661009e565b6040805160ff9092168252519081900360200190f35b34801561009357600080fd5b5061009c6100dd565b005b6000600160ff8416600a81106100b057fe5b0160ff8316600a81106100bf57fe5b602081049091015460ff601f9092166101000a900416905092915050565b6000543373ffffffffffffffffffffffffffffffffffffffff9081169116141561011c5760005473ffffffffffffffffffffffffffffffffffffffff16ff5b5600a165627a7a72305820df725bc7ae3ce379da2291d6bfd04dfb4b9ff907da250a7bc14efd9a6bbcc9e40029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })

 //Submitted contract creation              
 //fullhash=0x66c14d93659b589f15fc3a1a313dbbfe219af72965cf7ab8b46662b78c4c8d80 
 //contract=0x419a042FF81beAD2838D6A506076da7dF3542cF3
 
 var mycarrayContract = web3.eth.contract([{"constant":true,"inputs":[{"name":"x","type":"uint8"},{"name":"y","type":"uint8"}],"name":"getValue","outputs":[{"name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]);
 mycarrayContract.at("0x419a042FF81beAD2838D6A506076da7dF3542cF3").getValue(1,1);
