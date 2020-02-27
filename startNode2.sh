DATADIR="./private2"
PORT=30302
RCPPORT=8542
IP_LOCAL=$(ipconfig getifaddr en0)
NETWORK_ID=15
ENODE=$(bootnode --nodekey private1/geth/nodekey -writeaddress)

echo DATADIR:${DATADIR}, PORT:${PORT}, RCPPORT:${RCPPORT}, IP_LOCAL:${IP_LOCAL}, NETWORK_ID:${NETWORK_ID}, ENODE:${ENODE}

# geth --datadir $DATADIR init ./genesis.json 
# geth --datadir $DATADIR account import --password ./accounts/passwdfile  ./accounts/keystore4-ba1e081c82bcddfd2011da6ea97d1e1241959010
# geth console \
# --datadir $DATADIR \
# --networkid $NETWORK_ID \
# --mine  \
# --rpc --rpcapi "admin,personal,eth,web3" \
# --port $PORT \
# --rpcaddr $IP_LOCAL \
# --rpcport $RCPPORT \
# --nodiscover \
# --unlock 0 \
# --password ./accounts/passwdfile
# --bootnodes=enode://${ENODE}@${IP_LOCAL}:30301 