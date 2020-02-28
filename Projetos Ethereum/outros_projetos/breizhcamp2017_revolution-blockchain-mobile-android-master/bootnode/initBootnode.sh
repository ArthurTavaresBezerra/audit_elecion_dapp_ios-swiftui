#!/bin/bash

DIR=`dirname "$0"`
export PATH=$DIR/geth:$PATH
VERSION=`geth version | grep ^Version:`
echo -e "\e[31mGeth $VERSION\e[0m"

echo '################'
echo '## clean dirs ##'
echo '################'
for i in `seq 1 2`;
do
    rm -rf node$i/geth/LOCK
    rm -rf node$i/geth/chaindata
    rm -rf node$i/geth/nodes/
    rm -rf node$i/history
done

echo '################'
echo "## Init nodes ##"
echo '################'
geth \
    --datadir node1 \
    init genesis.json

geth \
    --datadir node2 \
    init genesis.json

# echo '###############'
# echo "## Geth warmup ##"
# echo '###############'
# geth \
#     --datadir node1 \
#     --ipcdisable \
#     js ./noop.js

# geth \
#     --datadir node2 \
#     --ipcdisable \
#     js ./noop.js


