cd /Users/arthurtavaresbezerra/repository/blockchain-tcc
echo "Abi Contract"
solc ./contracts/votacao.sol --abi
echo "Compile Contract"
solc ./contracts/votacao.sol --bin
