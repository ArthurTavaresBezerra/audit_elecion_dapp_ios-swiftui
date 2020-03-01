cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
geth --jspath "./scripts/scriptsJs" --exec 'loadScript("testSmartContracts.js")' attach ipc:./nodes/private1/geth.ipc