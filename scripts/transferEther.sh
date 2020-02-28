cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
echo "Transfer Ether"
geth --jspath "./scripts/scriptsJs" --exec 'loadScript("transferEther.js")' attach ipc:./nodes/private1/geth.ipc
