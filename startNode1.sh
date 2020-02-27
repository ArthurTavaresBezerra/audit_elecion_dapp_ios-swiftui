geth --datadir ./private1 init ./genesis.json 
geth --datadir ./private1 account import --password ./accounts/passwdfile  ./accounts/keystore1
geth --datadir ./private1 account import --password ./accounts/passwdfile  ./accounts/keystore2
geth --datadir ./private1 account import --password ./accounts/passwdfile  ./accounts/keystore3
geth console --datadir ./private1 --networkid 15 --mine  --rpc --rpcapi "admin,personal,eth,web3" --port 30301 --rpcaddr 192.168.1.10 --rpcport 8541 --nodiscover --unlock 0,1,2 --password ./passwdfile