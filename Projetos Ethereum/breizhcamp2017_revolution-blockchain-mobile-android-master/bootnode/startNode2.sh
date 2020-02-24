#!/bin/bash

DIR=`dirname "$0"`
export PATH=$DIR/geth:$PATH
VERSION=`geth version | grep ^Version:`
echo -e "\e[31mGeth $VERSION\e[0m"

geth \
    --datadir node2 \
    --networkid 100 \
    --port 30304 \
    --rpc \
    --rpcport 8546 \
    --rpcapi 'admin,debug,eth,miner,net,personal,shh,txpool,web3' \
    --unlock 0 \
    --password <(echo passwd) \
    --autodag \
    --preload ./mine.js \
    --ipcdisable \
    console
