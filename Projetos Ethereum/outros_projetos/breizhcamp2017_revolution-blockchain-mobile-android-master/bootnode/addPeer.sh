#!/bin/bash

DIR=`dirname "$0"`
export PATH=$DIR/geth:$PATH
VERSION=`geth version | grep ^Version:`
echo -e "\e[31mGeth $VERSION\e[0m"

echo '###############'
echo "## Add peer ##"
echo '###############'
geth \
    --exec 'admin.addPeer('$(geth --exec 'admin.nodeInfo.enode' attach rpc:http://localhost:8546)')' \
    attach rpc:http://localhost:8545
