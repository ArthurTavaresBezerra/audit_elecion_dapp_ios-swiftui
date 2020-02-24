pragma solidity ^0.4.22;

//import "./JsmnSolLib.sol";

contract Votacao {
   
    struct Voto { 
        string uf;
        string cmun;
        string idCandidato;
        uint256 voteCount; 
    } 
    
    struct Candidato {
        string id; 
        string uf;
        string cmun;
        uint256 voteCount;
    }
    
    struct BU {
        string id;
        Voto[] votos;
    }
     
    //Candidato[] candidatos ;
    mapping(string => Candidato) candidatos;
    mapping(string => BU) bus;
    uint256 countCandidatos;
    uint256[] counts;

    constructor() public {
        //candidatos = new Candidato[](0);
    }
 
    function vote(string pidBu, string pidCandidato, string puf, string pcmun, uint256 pvoteCount) public  {
        
        if (strIsEmpty(bus[pidBu].id)){
            bus[pidBu].id = pidBu;
        }
        
        bool isJaFoiVotado = false;
        for (uint i = 0; i < bus[pidBu].votos.length; i++) {
            if (strCompare(bus[pidBu].votos[i].idCandidato,pidCandidato) == 0) {
                if (strCompare(bus[pidBu].votos[i].uf,puf) == 0 && strCompare(bus[pidBu].votos[i].cmun,pcmun) == 0) {
                    isJaFoiVotado = true;
                    break;
                }
            }
        }
        
        require(!isJaFoiVotado, "Apenas um voto é permitido.");
        
        bus[pidBu].votos.push(Voto({uf:puf, cmun:pcmun, idCandidato:pidCandidato, voteCount:pvoteCount}));

        bool isCandidatoInserido = false;
        string memory hashCandidato = getHashCandidato(pidCandidato,puf,pcmun);
        if (strIsEmpty(candidatos[hashCandidato].id) == false)
        {
            candidatos[hashCandidato] = Candidato({id:pidCandidato, uf:puf, cmun:pcmun, voteCount:pvoteCount });
            countCandidatos += 1;
        }

        candidatos[hashCandidato].voteCount += pvoteCount;
        isCandidatoInserido = true;

        
        //for (uint j = 0; j < candidatos.length; j++) {
        //    if (strCompare(candidatos[j].id,pidCandidato) == 0 && candidatos[j].uf == puf && candidatos[j].cmun == pcmun)
        //    {
        //        candidatos[j].voteCount += pvoteCount;
        //        isCandidatoInserido = true;
        //    }
        //}
        
        //if (!isCandidatoInserido) {
        //    candidatos.push(Candidato({id:pidCandidato, uf:puf, cmun:pcmun, voteCount:pvoteCount }));
        //}
    }
  
    function getTotalVotosPorCandidato(string pidCandidato, string puf, string pcmun) public view returns (uint256 total)
    {
        string memory hashCandidato = getHashCandidato(pidCandidato,puf,pcmun);
        candidatos[hashCandidato].voteCount;

        //for (uint j = 0; j < candidatos.length; j++) {
        //    if (strCompare(candidatos[j].id, pidCandidato) == 0 && candidatos[j].uf == puf && candidatos[j].cmun == pcmun)
        //    {
        //        return candidatos[j].voteCount;
        //    }
        //}
    }

    function getTotalCandidatos() public view returns (uint256 total)
    {
        return countCandidatos;
    }

    function getTestHash(string pidCandidato, string puf, string pcmun) public view returns (string)
    {
        return getHashCandidato(pidCandidato,puf,pcmun);
    }
    
    function strCompare(string _a, string _b) internal pure returns (int) {
        bytes memory a = bytes(_a);
        bytes memory b = bytes(_b);
        uint minLength = a.length;
        if (b.length < minLength) minLength = b.length;
        for (uint i = 0; i < minLength; i ++)
            if (a[i] < b[i])
                return -1;
            else if (a[i] > b[i])
        return 1;
        if (a.length < b.length)
            return -1;
        else if (a.length > b.length)
            return 1;
        else
            return 0;
    }
     
    function strIsEmpty(string _a) internal pure returns (bool) {
        bytes memory a = bytes(_a);
        return (a.length == 0); 
    }

    function getHashCandidato(string pId, string pUf, string pCmun) internal pure returns (string retorno) {
        retorno = concat(pId, pUf);
        retorno = concat(retorno,pCmun);
    } 

    function inc() public returns (uint) {
        counts.push(4);
    }

    function get() public view returns (uint) {
        return counts.length;
    }

    function concat(string _base, string _value) public pure returns (string) {
        bytes memory _baseBytes = bytes(_base);
        bytes memory _valueBytes = bytes(_value);

        string memory _tmpValue = new string(_baseBytes.length + _valueBytes.length);
        bytes memory _newValue = bytes(_tmpValue);

        uint i;
        uint j;

        for(i = 0; i < _baseBytes.length; i++) {
            _newValue[j++] = _baseBytes[i];
        }

        for(i = 0; i < _valueBytes.length; i++) {
            _newValue[j++] = _valueBytes[i++];
        }

        return string(_newValue);
    } 
}


/*

0x82255064
00000000000000000000000000000000000000000000000000000000000000a0
00000000000000000000000000000000000000000000000000000000000000e0
0000000000000000000000000000000000000000000000000000000000000001
0000000000000000000000000000000000000000000000000000000000000002
0000000000000000000000000000000000000000000000000000000000000003
0000000000000000000000000000000000000000000000000000000000000001
6100000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000001
6200000000000000000000000000000000000000000000000000000000000000

a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1a1
b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2b2

0x82255064
00000000000000000000000000000000000000000000000000000000000000a0
0000000000000000000000000000000000000000000000000000000000000100
0000000000000000000000000000000000000000000000000000000000003039
000000000000000000000000000000000000000000000000000000000000153a
00000000000000000000000000000000000000000000000000000000000000ff
0000000000000000000000000000000000000000000000000000000000000040
6131613161316131613161316131613161316131613161316131613161316131
6131613161316131613161316131613161316131613161316131613161316131
0000000000000000000000000000000000000000000000000000000000000040
6232623262326232623262326232623262326232623262326232623262326232
6232623262326232623262326232623262326232623262326232623262326232


0x82255064
00000000000000000000000000000000000000000000000000000000000000a0
0000000000000000000000000000000000000000000000000000000000000100
00000000000000000000000000000000000000000000000000000000000000e7
0000000000000000000000000000000000000000000000000000000000bbdf03
00000000000000000000000000000000000000000000000000000000000f423f
0000000000000000000000000000000000000000000000000000000000000040
6131613161316131613161316131613161316131613161316131613161316131
6131613161316131613161316131613161316131613161316131613161316131
0000000000000000000000000000000000000000000000000000000000000040
6232623262326232623262326232623262326232623262326232623262326232
6232623262326232623262326232623262326232623262326232623262326232




0x8225506400000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000e00000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000002613100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000026331000000000000000000000000000000000000000000000000000000000000

0xaa8b69fe
0000000000000000000000000000000000000000000000000000000000000060
0000000000000000000000000000000000000000000000000000000000000001
0000000000000000000000000000000000000000000000000000000000000002
0000000000000000000000000000000000000000000000000000000000000002
6331000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000

*/