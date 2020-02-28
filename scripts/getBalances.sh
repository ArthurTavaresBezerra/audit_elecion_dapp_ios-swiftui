cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
echo "Balanço Node1"
geth --jspath "./scripts/scriptsJs" --exec 'loadScript("getBalances.js")' attach ipc:./nodes/private1/geth.ipc
echo "Balanço Node2"
geth --jspath "./scripts/scriptsJs" --exec 'loadScript("getBalances.js")' attach ipc:./nodes/private2/geth.ipc
echo "Balanço Node3"
geth --jspath "./scripts/scriptsJs" --exec 'loadScript("getBalances.js")' attach ipc:./nodes/private3/geth.ipc