cd /Users/arthurtavaresbezerra/repository/blockchain-tcc
echo "Transfer Ether"
geth --jspath "./sc" --exec 'loadScript("transferEther.js")' attach ipc:./private1/geth.ipc
