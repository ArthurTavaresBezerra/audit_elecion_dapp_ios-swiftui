cd /opt/geth
DATADIR="./nodes/private3"
PORT=30303
RCPPORT=8543
IP_LOCAL=172.31.2.140
NETWORK_ID=15
ENODE=$(bootnode --nodekey nodes/private1/geth/nodekey -writeaddress)

echo PWD:${PWD}, DATADIR:${DATADIR}, PORT:${PORT}, RCPPORT:${RCPPORT}, IP_LOCAL:${IP_LOCAL}, NETWORK_ID:${NETWORK_ID}, ENODE:${ENODE}

/opt/geth/geth --datadir $DATADIR init ./nodes/genesis.json 
/opt/geth/geth --datadir $DATADIR account import --password ./accounts/passwdfile  ./accounts/keystore1-019b2231c3cd4e4f3115ea69573014702d4cbb23
/opt/geth/geth \
--datadir $DATADIR \
--networkid $NETWORK_ID \
--rpc --rpcapi "admin,personal,eth,web3" \
--port $PORT \
--rpcaddr $IP_LOCAL \
--rpcport $RCPPORT \
--password ./accounts/passwdfile \
--bootnodes=enode://${ENODE}@${IP_LOCAL}:30301 & 