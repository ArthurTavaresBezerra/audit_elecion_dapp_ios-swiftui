#!/bin/bash

DIR=`dirname "$0"`
export PATH=$DIR/geth:$PATH
VERSION=`geth version | grep ^Version:`
echo -e "\e[31mGeth $VERSION\e[0m"

echo 'NODE 1 :' $(geth --exec 'admin.nodeInfo.id' attach rpc:http://localhost:8545)
echo 'NODE 2 :' $(geth --exec 'admin.nodeInfo.id' attach rpc:http://localhost:8546)
