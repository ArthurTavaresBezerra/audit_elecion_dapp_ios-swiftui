pragma solidity ^0.4.23;

/*library Strings {

    function concat(string _base, string _value) internal returns (string) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);

        string memory _tmpValue = new string(_baseBytes.length + _valueBytes.length);
        bytes memory _newValue = bytes(_tmpValue);

        uint i;
        uint j;

        for(i=0; i<_baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }

        for(i=0; i<_valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i++];
        }

        return string(_newValue);
    } 
    
}*/ 

contract Teste1 {  
     
    function write1(string str) public  pure returns (string) 
    {   
        return str;
    } 
     
}
