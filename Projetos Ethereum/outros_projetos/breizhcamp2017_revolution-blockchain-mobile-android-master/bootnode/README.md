# BOOTNODE

Fonctionne avec Geth < 1.6

Liens téléchargement 
* [Geth 1.5.9 Linux 64-bit](https://gethstore.blob.core.windows.net/builds/geth-linux-amd64-1.5.9-a07539fb.tar.gz) 
* [Autres versions](https://geth.ethereum.org/downloads/)

Extraire le contenu de l'archive dans le dossier local `geth`.

## Init de la Blockchain privée

    ./initBootnode.sh

## Lancement des 2 noeuds (2 fenêtres différentes) 

    ./startNode1.sh
    ./startNode2.sh

## Synchronisation des noeuds

    ./addPeer.sh

## Crédit du compte du speaker
    
Copier l'identifiant depuis la console android

    ./sendMoney.sh 0x....

## Envoi d'un message (exemple)

Depuis la console d'un des deux noeuds Geth

    > eth.sendTransaction({from:eth.coinbase,to:eth.coinbase,data:web3.toHex('hello world')})
