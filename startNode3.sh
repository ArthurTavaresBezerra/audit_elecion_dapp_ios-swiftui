geth --datadir ./private2 init ./genesis.json 
geth --datadir ./private2 account import --password ./accounts/passwdfile  ./accounts/keystore5-ea685b9f731aecd7c91a8d98b6f2021e20a5e049
geth console \
--datadir ./private2 \
--networkid 15 \
--mine  \
--rpc --rpcapi "admin,personal,eth,web3" \
--port 30302 \
--rpcaddr 192.168.1.10 \
--rpcport 8542 \
--nodiscover \
--unlock 0 \
--password ./accounts/passwdfile
--bootnodes=enode://ade014498c7295d6ff0c3938d7f0f25faf164b216122ab45d6ba64aa5707d84eb93c1f7fb9149b040b57db56ea1a21874c4fe49d9b9f82e698b18536836faa49@192.168.1.10:30301