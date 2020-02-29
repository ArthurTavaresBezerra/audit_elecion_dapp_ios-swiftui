cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
DATADIR="./nodes/private3"
PORT=30303
RCPPORT=8543
IP_LOCAL=$(ipconfig getifaddr en0)
NETWORK_ID=15
ENODE=$(bootnode --nodekey nodes/private1/geth/nodekey -writeaddress)

echo PWD:${PWD}, DATADIR:${DATADIR}, PORT:${PORT}, RCPPORT:${RCPPORT}, IP_LOCAL:${IP_LOCAL}, NETWORK_ID:${NETWORK_ID}, ENODE:${ENODE}

geth --datadir $DATADIR init ./nodes/genesis.json 
geth --datadir $DATADIR account import --password ./accounts/passwdfile  ./accounts/keystore5-ea685b9f731aecd7c91a8d98b6f2021e20a5e049
geth console \
--datadir $DATADIR \
--networkid $NETWORK_ID \
--rpc --rpcapi "admin,personal,eth,web3" \
--port $PORT \
--rpcaddr $IP_LOCAL \
--rpcport $RCPPORT \
--unlock 0 \
--password ./accounts/passwdfile \
--bootnodes=enode://${ENODE}@${IP_LOCAL}:30301 
