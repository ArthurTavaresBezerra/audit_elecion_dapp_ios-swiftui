cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
DATADIR="./nodes/private1"
PORT=30301
RCPPORT=8541
IP_LOCAL=$(ipconfig getifaddr en0)
NETWORK_ID=15

echo PWD:${PWD}, DATADIR:${DATADIR}, PORT:${PORT}, RCPPORT:${RCPPORT}, IP_LOCAL:${IP_LOCAL}, NETWORK_ID:${NETWORK_ID}
#— identity “yourIdentity” — init /path_to_folder/CustomGenesis.json
geth --datadir $DATADIR account import --password ./accounts/passwdfile  ./accounts/keystore1-019b2231c3cd4e4f3115ea69573014702d4cbb23
geth --datadir $DATADIR init ./nodes/genesis.json 
geth --datadir $DATADIR account import --password ./accounts/passwdfile  ./accounts/keystore2-481b0688e27d00dc7fd66c393228c1f59c9c2559
geth --datadir $DATADIR account import --password ./accounts/passwdfile  ./accounts/keystore3-09ffa2c2b2e7d6d7266cf6199a4e7e4ae2cfc434
geth console \
--datadir $DATADIR \
--networkid $NETWORK_ID \
--rpc --rpcapi "admin,personal,eth,web3" \
--port $PORT \
--rpcaddr $IP_LOCAL \
--rpcport $RCPPORT \
--unlock 0,1,2 \
--password ./accounts/passwdfile \
--mine
