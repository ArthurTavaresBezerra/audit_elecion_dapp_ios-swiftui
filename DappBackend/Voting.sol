pragma solidity ^0.5.0;

contract SmartELection {

    struct Voto {
        string idCandidato;
        uint256 voteCount;
    }

    struct Candidato {
        string id;
        uint uf;
        uint cmun;
        uint256 voteCount;
    }

    struct BU {
        uint uf;
        uint cmun;
        string id;
        Voto[] votos;
    }

    Candidato[] candidatos;
    mapping(string => BU) bus;

    function vote(string memory pidBu, string memory pidCandidato, uint puf, uint pcmun, uint256 pvoteCount) public {

        if (strIsEmpty(bus[pidBu].id)){
            bus[pidBu].id = pidBu;
            bus[pidBu].uf = puf;
            bus[pidBu].cmun = pcmun;
        }

        bool isJaFoiVotado = false;
        for (uint i = 0; i < bus[pidBu].votos.length; i++) {
            if (strCompare(bus[pidBu].votos[i].idCandidato,pidCandidato) == 0) {
                isJaFoiVotado = true;
                break;
            }
        }

        require(!isJaFoiVotado, "Apenas um voto é permitido por boletim de urna.");

        bus[pidBu].votos.push(Voto({idCandidato:pidCandidato, voteCount:pvoteCount}));

        bool isCandidatoInserido = false;
        for (uint j = 0; j < candidatos.length; j++) {
            if (strCompare(candidatos[j].id,pidCandidato) == 0 && candidatos[j].uf == puf && candidatos[j].cmun == pcmun)
            {
                candidatos[j].voteCount += pvoteCount;
                isCandidatoInserido = true;
            }
        }

        if (!isCandidatoInserido) {
            candidatos.push(Candidato({id:pidCandidato, uf:puf, cmun:pcmun, voteCount:pvoteCount }));

        }
    }

    function getTotalVotosPorCandidato(string memory pidCandidato, uint puf, uint pcmun) public view returns (uint256 total )
    {
        bool isIgnoraMunicipio = pcmun <= 0;
        bool isIgnoraUf = puf <= 0;

        for (uint j = 0; j < candidatos.length; j++) {

            if (strCompare(candidatos[j].id, pidCandidato) == 0)
            {
                if ( (isIgnoraUf || candidatos[j].uf == puf) && (isIgnoraMunicipio || candidatos[j].cmun == pcmun))

                total += candidatos[j].voteCount;
            }
        }
    }

    function getTotalCandidatos() public view returns (uint256 total)
    {
        return candidatos.length;
    }

    function strCompare(string memory _a, string memory _b) internal pure returns (int) {
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

    function strIsEmpty(string memory _a) internal pure returns (bool) {
        bytes memory a = bytes(_a);
        return (a.length == 0);
    }
}