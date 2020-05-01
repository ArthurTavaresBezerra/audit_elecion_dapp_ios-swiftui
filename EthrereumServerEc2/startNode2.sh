cd /opt/geth
DATADIR="./nodes/private2"
PORT=30302
RCPPORT=8542
IP_LOCAL=172.31.2.140
NETWORK_ID=15
ENODE=$(bootnode --nodekey nodes/private1/geth/nodekey -writeaddress)

echo PWD:${PWD}, DATADIR:${DATADIR}, PORT:${PORT}, RCPPORT:${RCPPORT}, IP_LOCAL:${IP_LOCAL}, NETWORK_ID:${NETWORK_ID}, ENODE:${ENODE}

/opt/geth/geth --datadir $DATADIR init ./nodes/genesis.json 
/opt/geth/geth --datadir $DATADIR account import --password ./accounts/passwdfile  ./accounts/keystore4-ba1e081c82bcddfd2011da6ea97d1e1241959010
/opt/geth/geth \
--datadir $DATADIR \
--networkid $NETWORK_ID \
--rpc --rpcapi "admin,personal,eth,web3" \
--port $PORT \
--rpcaddr $IP_LOCAL \
--rpcport $RCPPORT \
--password ./accounts/passwdfile \
--bootnodes=enode://${ENODE}@${IP_LOCAL}:30301 & 