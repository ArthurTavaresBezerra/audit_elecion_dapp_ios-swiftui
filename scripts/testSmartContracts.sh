cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
RCPPORT=8541
IP_LOCAL=$(ipconfig getifaddr en0)

###########curl --data '{"jsonrpc":"2.0","method": "eth_getCompilers", "id": 3}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT
###########curl --data '{"jsonrpc":"2.0","method": "eth_compileSolidity", "params": ["contract Multiply7 { event Print(uint); function multiply(uint input) returns (uint) { Print(input * 7); return input * 7; } }"], "id": 4}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT

# curl --data '{"jsonrpc":"2.0","method": "eth_estimateGas", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "data": "0x608060405234801561001057600080fd5b50610c2b806100206000396000f3fe608060405234801561001057600080fd5b50600436106100575760003560e01c8063209652551461005c5780634911c08e146100765780637b8d56e31461007e57806382255064146100a3578063aa8b69fe146101db575b600080fd5b610064610286565b60408051918252519081900360200190f35b6100646102b4565b6100a16004803603604081101561009457600080fd5b50803590602001356102ba565b005b6100a1600480360360a08110156100b957600080fd5b8101906020810181356401000000008111156100d457600080fd5b8201836020820111156100e657600080fd5b8035906020019184600183028401116401000000008311171561010857600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250929594936020810193503591505064010000000081111561015b57600080fd5b82018360208201111561016d57600080fd5b8035906020019184600183028401116401000000008311171561018f57600080fd5b91908080601f01602080910402602001604051908101604052809392919081815260200183838082843760009201919091525092955050823593505050602081013590604001356102c5565b610064600480360360608110156101f157600080fd5b81019060208101813564010000000081111561020c57600080fd5b82018360208201111561021e57600080fd5b8035906020019184600183028401116401000000008311171561024057600080fd5b91908080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152509295505082359350505060200135610969565b60008060025411801561029b57506000600354115b156102ad5750600354600254026102b1565b5060ff5b90565b60005490565b600291909155600355565b6103bb6001866040518082805190602001908083835b602083106102fa5780518252601f1990920191602091820191016102db565b518151600019602094850361010090810a8201928316921993909316919091179092529490920196875260408051978890038201882060029081018054601f6001821615909802909501909416049485018290048202880182019052838752909450919250508301828280156103b15780601f10610386576101008083540402835291602001916103b1565b820191906000526020600020905b81548152906001019060200180831161039457829003601f168201915b5050505050610a23565b1561050657846001866040518082805190602001908083835b602083106103f35780518252601f1990920191602091820191016103d4565b51815160209384036101000a60001901801990921691161790529201948552506040519384900381019093208451610438956002909201949190910192509050610b2d565b50826001866040518082805190602001908083835b6020831061046c5780518252601f19909201916020918201910161044d565b51815160209384036101000a6000190180199092169116179052920194855250604051938490038101842094909455505086518492600192899290918291908401908083835b602083106104d15780518252601f1990920191602091820191016104b2565b51815160209384036101000a600019018019909216911617905292019485525060405193849003019092206001019290925550505b6000805b6001876040518082805190602001908083835b6020831061053c5780518252601f19909201916020918201910161051d565b51815160209384036101000a6000190180199092169116179052920194855250604051938490030190922060030154831015915061069c9050576106876001886040518082805190602001908083835b602083106105ab5780518252601f19909201916020918201910161058c565b51815160209384036101000a60001901801990921691161790529201948552506040519384900301909220600301805490925084915081106105e957fe5b60009182526020918290206002918202018054604080516001831615610100026000190190921693909304601f81018590048502820185019093528281529290919083018282801561067c5780601f106106515761010080835404028352916020019161067c565b820191906000526020600020905b81548152906001019060200180831161065f57829003601f168201915b505050505087610a28565b610694576001915061069c565b60010161050a565b5080156106da5760405162461bcd60e51b8152600401808060200182810382526030815260200180610bc66030913960400191505060405180910390fd5b6001866040518082805190602001908083835b6020831061070c5780518252601f1990920191602091820191016106ed565b51815160209384036101000a600019018019909216911617905292019485525060408051948590038201852085820190915289855284820187905260030180546001810182556000918252908290208551805160029093029091019450610777935084920190610b2d565b50602091909101516001909101556000805b6000548110156108ce57610841600082815481106107a357fe5b6000918252602091829020600490910201805460408051601f60026000196101006001871615020190941693909304928301859004850281018501909152818152928301828280156108365780601f1061080b57610100808354040283529160200191610836565b820191906000526020600020905b81548152906001019060200180831161081957829003601f168201915b505050505088610a28565b15801561086b5750856000828154811061085757fe5b906000526020600020906004020160010154145b80156108945750846000828154811061088057fe5b906000526020600020906004020160020154145b156108c65783600082815481106108a757fe5b6000918252602090912060036004909202010180549091019055600191505b600101610789565b508061096057604080516080810182528781526020808201889052918101869052606081018590526000805460018101825590805281518051929360049092027f290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563019261093e9284920190610b2d565b5060208201518160010155604082015181600201556060820151816003015550505b50505050505050565b600081158315825b600054811015610a195761098b600082815481106107a357fe5b610a115781806109b8575085600082815481106109a457fe5b906000526020600020906004020160010154145b80156109e8575082806109e8575084600082815481106109d457fe5b906000526020600020906004020160020154145b15610a1157600081815481106109fa57fe5b906000526020600020906004020160030154840193505b600101610971565b5050509392505050565b511590565b815181516000918491849190811115610a3f575080515b60005b81811015610af157828181518110610a5657fe5b602001015160f81c60f81b6001600160f81b031916848281518110610a7757fe5b01602001516001600160f81b0319161015610a9a57600019945050505050610b27565b828181518110610aa657fe5b602001015160f81c60f81b6001600160f81b031916848281518110610ac757fe5b01602001516001600160f81b0319161115610ae9576001945050505050610b27565b600101610a42565b50815183511015610b09576000199350505050610b27565b815183511115610b1f5760019350505050610b27565b600093505050505b92915050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f10610b6e57805160ff1916838001178555610b9b565b82800160010185558215610b9b579182015b82811115610b9b578251825591602001919060010190610b80565b50610ba7929150610bab565b5090565b6102b191905b80821115610ba75760008155600101610bb156fe4170656e617320756d20766f746f20c3a9207065726d697469646f20706f7220626f6c6574696d2064652075726e612ea2646970667358221220254475ca7c7a0796afc15f4fae36126a970686aea81c299017ee9a84c466137b64736f6c63430006010033"}], "id": 5}'  -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT

# # solc --bin contracts/outros/multiply.sol

# curl --data '{"jsonrpc":"2.0","method": "eth_sendTransaction", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "gas": "0xd761d", "data": "0x608060405234801561001057600080fd5b50610c2b806100206000396000f3fe608060405234801561001057600080fd5b50600436106100575760003560e01c8063209652551461005c5780634911c08e146100765780637b8d56e31461007e57806382255064146100a3578063aa8b69fe146101db575b600080fd5b610064610286565b60408051918252519081900360200190f35b6100646102b4565b6100a16004803603604081101561009457600080fd5b50803590602001356102ba565b005b6100a1600480360360a08110156100b957600080fd5b8101906020810181356401000000008111156100d457600080fd5b8201836020820111156100e657600080fd5b8035906020019184600183028401116401000000008311171561010857600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250929594936020810193503591505064010000000081111561015b57600080fd5b82018360208201111561016d57600080fd5b8035906020019184600183028401116401000000008311171561018f57600080fd5b91908080601f01602080910402602001604051908101604052809392919081815260200183838082843760009201919091525092955050823593505050602081013590604001356102c5565b610064600480360360608110156101f157600080fd5b81019060208101813564010000000081111561020c57600080fd5b82018360208201111561021e57600080fd5b8035906020019184600183028401116401000000008311171561024057600080fd5b91908080601f0160208091040260200160405190810160405280939291908181526020018383808284376000920191909152509295505082359350505060200135610969565b60008060025411801561029b57506000600354115b156102ad5750600354600254026102b1565b5060ff5b90565b60005490565b600291909155600355565b6103bb6001866040518082805190602001908083835b602083106102fa5780518252601f1990920191602091820191016102db565b518151600019602094850361010090810a8201928316921993909316919091179092529490920196875260408051978890038201882060029081018054601f6001821615909802909501909416049485018290048202880182019052838752909450919250508301828280156103b15780601f10610386576101008083540402835291602001916103b1565b820191906000526020600020905b81548152906001019060200180831161039457829003601f168201915b5050505050610a23565b1561050657846001866040518082805190602001908083835b602083106103f35780518252601f1990920191602091820191016103d4565b51815160209384036101000a60001901801990921691161790529201948552506040519384900381019093208451610438956002909201949190910192509050610b2d565b50826001866040518082805190602001908083835b6020831061046c5780518252601f19909201916020918201910161044d565b51815160209384036101000a6000190180199092169116179052920194855250604051938490038101842094909455505086518492600192899290918291908401908083835b602083106104d15780518252601f1990920191602091820191016104b2565b51815160209384036101000a600019018019909216911617905292019485525060405193849003019092206001019290925550505b6000805b6001876040518082805190602001908083835b6020831061053c5780518252601f19909201916020918201910161051d565b51815160209384036101000a6000190180199092169116179052920194855250604051938490030190922060030154831015915061069c9050576106876001886040518082805190602001908083835b602083106105ab5780518252601f19909201916020918201910161058c565b51815160209384036101000a60001901801990921691161790529201948552506040519384900301909220600301805490925084915081106105e957fe5b60009182526020918290206002918202018054604080516001831615610100026000190190921693909304601f81018590048502820185019093528281529290919083018282801561067c5780601f106106515761010080835404028352916020019161067c565b820191906000526020600020905b81548152906001019060200180831161065f57829003601f168201915b505050505087610a28565b610694576001915061069c565b60010161050a565b5080156106da5760405162461bcd60e51b8152600401808060200182810382526030815260200180610bc66030913960400191505060405180910390fd5b6001866040518082805190602001908083835b6020831061070c5780518252601f1990920191602091820191016106ed565b51815160209384036101000a600019018019909216911617905292019485525060408051948590038201852085820190915289855284820187905260030180546001810182556000918252908290208551805160029093029091019450610777935084920190610b2d565b50602091909101516001909101556000805b6000548110156108ce57610841600082815481106107a357fe5b6000918252602091829020600490910201805460408051601f60026000196101006001871615020190941693909304928301859004850281018501909152818152928301828280156108365780601f1061080b57610100808354040283529160200191610836565b820191906000526020600020905b81548152906001019060200180831161081957829003601f168201915b505050505088610a28565b15801561086b5750856000828154811061085757fe5b906000526020600020906004020160010154145b80156108945750846000828154811061088057fe5b906000526020600020906004020160020154145b156108c65783600082815481106108a757fe5b6000918252602090912060036004909202010180549091019055600191505b600101610789565b508061096057604080516080810182528781526020808201889052918101869052606081018590526000805460018101825590805281518051929360049092027f290decd9548b62a8d60345a988386fc84ba6bc95484008f6362f93160ef3e563019261093e9284920190610b2d565b5060208201518160010155604082015181600201556060820151816003015550505b50505050505050565b600081158315825b600054811015610a195761098b600082815481106107a357fe5b610a115781806109b8575085600082815481106109a457fe5b906000526020600020906004020160010154145b80156109e8575082806109e8575084600082815481106109d457fe5b906000526020600020906004020160020154145b15610a1157600081815481106109fa57fe5b906000526020600020906004020160030154840193505b600101610971565b5050509392505050565b511590565b815181516000918491849190811115610a3f575080515b60005b81811015610af157828181518110610a5657fe5b602001015160f81c60f81b6001600160f81b031916848281518110610a7757fe5b01602001516001600160f81b0319161015610a9a57600019945050505050610b27565b828181518110610aa657fe5b602001015160f81c60f81b6001600160f81b031916848281518110610ac757fe5b01602001516001600160f81b0319161115610ae9576001945050505050610b27565b600101610a42565b50815183511015610b09576000199350505050610b27565b815183511115610b1f5760019350505050610b27565b600093505050505b92915050565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f10610b6e57805160ff1916838001178555610b9b565b82800160010185558215610b9b579182015b82811115610b9b578251825591602001919060010190610b80565b50610ba7929150610bab565b5090565b6102b191905b80821115610ba75760008155600101610bb156fe4170656e617320756d20766f746f20c3a9207065726d697469646f20706f7220626f6c6574696d2064652075726e612ea2646970667358221220254475ca7c7a0796afc15f4fae36126a970686aea81c299017ee9a84c466137b64736f6c63430006010033"}], "id": 6}'  -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT
# curl --data '{"jsonrpc":"2.0","method": "eth_getTransactionReceipt", "params": ["0x93247d2667d050e66a600df6b55fd232b51badaeb11c73f76ab4965c540d17a9"], "id": 7}'   -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT

####Executar o Multiply
# echo "RPC - multiply - sendTransactions "
# curl --data '{"jsonrpc":"2.0","method": "eth_sendTransaction", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0x6d655ad34f9900f8f39105f33a2a530f34b2a5c8", "data": "0xc6888fa10000000000000000000000000000000000000000000000000000000000000002"}], "id": 8}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT
# echo "RPC - multiply - call "
# curl $IP_LOCAL:$RCPPORT -X POST --data '{"jsonrpc":"2.0", "method":"eth_call", "params":[{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0x6d655ad34f9900f8f39105f33a2a530f34b2a5c8", "data": "0xc6888fa10000000000000000000000000000000000000000000000000000000000000003"}, "latest"], "id":1}' -H "Content-Type: application/json"

# CONTRACT_ADDRESS="0x4e99a8a5dec5736cc5f4daa2b34457f3cb01e1de"
#####Executar o Vote com transactions
##Vote sha3   vote(string,string,uint256,uint256,uint256)  0x82255064

# echo "RPC - vote"
# curl --data '{"jsonrpc":"2.0","method": "eth_sendTransaction", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0xc061d7f91cf1f05135e95f5a6e35bd86c253c415", "data": "0x8225506400000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000030000000000000000000000000000000000000000000000000000000000000001310000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000013100000000000000000000000000000000000000000000000000000000000000"}], "id": 2}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT
# echo "RPC - GetResult"
# curl --data '{"jsonrpc":"2.0","method": "eth_call", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0xc061d7f91cf1f05135e95f5a6e35bd86c253c415", "data": "0xde292789"}, "latest"], "id": 3}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT
# echo "RPC - GetResult"
# curl --data '{"jsonrpc":"2.0","method": "eth_call", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0xc061d7f91cf1f05135e95f5a6e35bd86c253c415", "data": "0x4911c08e"}, "latest"], "id": 3}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT

 
# echo "RPC - getValue"
# curl --data '{"jsonrpc":"2.0","method": "eth_call", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0xbd57423234c9a31565ccbbbf0fa9f577a8d97d47", "data": "0x20965255"}, "latest"], "id": 1}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT

# echo "RPC - setValue"
# curl --data '{"jsonrpc":"2.0","method": "eth_sendTransaction", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0xbd57423234c9a31565ccbbbf0fa9f577a8d97d47", "data": "0x7b8d56e300000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002"}], "id": 2}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT

# echo "RPC - getValue"
# curl --data '{"jsonrpc":"2.0","method": "eth_call", "params": [{"from": "0x019b2231c3cd4e4f3115ea69573014702d4cbb23", "to": "0xbd57423234c9a31565ccbbbf0fa9f577a8d97d47", "data": "0x20965255"}, "latest"], "id": 3}' -H "Content-Type: application/json" $IP_LOCAL:$RCPPORT


geth --jspath "./scripts/scriptsJs" --exec 'loadScript("testSmartContracts.js")' attach ipc:./nodes/private1/geth.ipc

 