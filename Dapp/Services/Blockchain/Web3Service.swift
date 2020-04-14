//
//  Web3.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 13/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//


import Foundation
//import web3

class Web3Service {
    
//    private var web3: web3
    private var contractByteCode : String = ""
    private var contractABI : String = ""
    private var ip : String = ""
    private var port : String = ""
    
    init() {
        self.contractByteCode = PListHelper.readProperty("auditelection-contract-bytecode")
        self.contractABI = PListHelper.readProperty("auditelection-contract-abi")
        self.ip = PListHelper.readProperty("firstnode-ip")
        self.port = PListHelper.readProperty("firstnode-port")
//        self.web3 = eb3(provider: InfuraProvider(Networks.Mainnet)!)
    }
    
    
//    func setLocalNode(port: Int = 8545) -> web3? {
//        let url : URL = URL(string: "http://\(self.ip):\(self.port)")!
//        let web3 =  Web3.InfuraRinkebyWeb3()
//        return web3
//    }


//
//    // Returns true if successful
//    private func sendToContract(address : String) -> Bool {
//        do {
//
//            let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//            let keystoreManager = KeystoreManager.managerForPath(userDir + "/keystore")
//
//            var ks: EthereumKeystoreV3?
//            if (keystoreManager?.addresses?.count == 0) {
//                ks = try! EthereumKeystoreV3(password: "BANKEXFOUNDATION")
//                let keydata = EthereumAddress("0xe1669a40f8356f1655e5052931b6f25d641ea6b6")//.addressData
//                FileManager.default.createFile(atPath: userDir + "/keystore"+"/key.json", contents: keydata?.addressData, attributes: nil)
//            } else {
//                ks = keystoreManager?.walletForAddress((keystoreManager?.addresses![0])!) as! EthereumKeystoreV3
//            }
//            guard let sender = ks?.addresses?.first else {
//                print("sender is empty");
//                return false;
//            }
//            print("0xe1669a40f8356f1655e5052931b6f25d641ea6b6")
//
//            var options = TransactionOptions()
//            options.from = EthereumAddress("0xe1669a40f8356f1655e5052931b6f25d641ea6b6")
//            let web3Rinkeby = Web3.InfuraRinkebyWeb3()
//            web3Rinkeby.addKeystoreManager(keystoreManager)
//            let coldWalletABI = "[{\"payable\":true,\"type\":\"fallback\"}]"
//            let coldWalletAddress = EthereumAddress("fd057dfbc822ccf6c4848c2ec1b580097810fbffacff6cf9a8eef401e751b196")
//            let constractAddress = EthereumAddress("0x958D2AbC4E3BCdb49BdE50B9A840231Eb7b9d1e1")
//
//            let contract = web3Rinkeby.contract(jsonString, at: constractAddress)
//            let intermediate = contract?.method(options: options)
//            var res = intermediate?.call(options: options)
//            guard let result = res else {print("Fail");return false;}
//
//            options = TransactionOptions.defaultOptions()
//            options.from = sender
//        } catch {
//            print(error)
//        }
//        return true;
//    }
}
