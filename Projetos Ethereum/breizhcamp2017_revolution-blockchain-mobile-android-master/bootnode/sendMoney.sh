#!/bin/bash

DIR=`dirname "$0"`
export PATH=$DIR/geth:$PATH
VERSION=`geth version | grep ^Version:`
echo -e "\e[31mGeth $VERSION\e[0m"

echo '########################'
echo '## Send Money to '$1' ##'
echo '########################'

geth \
    --exec 'eth.sendTransaction({from:eth.coinbase,to:"'$1'",value:web3.toWei(10,"ether")})' \
    attach rpc:http://localhost:8545
