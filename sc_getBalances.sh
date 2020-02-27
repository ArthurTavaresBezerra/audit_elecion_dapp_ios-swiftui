cd /Users/arthurtavaresbezerra/repository/blockchain-tcc
echo "Balanço Node1"
geth --jspath "./sc" --exec 'loadScript("getBalances.js")' attach ipc:./private1/geth.ipc
echo "Balanço Node2"
geth --jspath "./sc" --exec 'loadScript("getBalances.js")' attach ipc:./private2/geth.ipc
echo "Balanço Node3"
geth --jspath "./sc" --exec 'loadScript("getBalances.js")' attach ipc:./private3/geth.ipc