//
//  AddBoletimViewModel.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 10/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation
import Combine

class AddBoletimViewModel: ObservableObject {

    private var task: AnyCancellable?
    
    @Published var isAlreadyExists: Bool = false
    @Published var isProcessing: Bool = false
    @Published var boletim : BoletimVM = BoletimVM(id: "", cUF: 0, cMum: 0, boletimDetalhes: [])
    @Published var qtdToProcess: Int = 0
    @Published var qtdProcessed: Int = 0

    func saveLocalAndBlockChain(){

        self.isProcessing = true
                    
            let dispatcher = DispatchGroup()
                  
            for c in 0...self.boletim.boletimCargos.count-1 {
                for i in 0...self.boletim.boletimDetalhes.count-1 {
                    
                    dispatcher.enter()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + count) {
                        self.boletim.boletimCargos[c].boletimDetalhes[i].isProcessado = true
                        self.qtdProcessed += 1
                        dispatcher.leave()
//                    }
//                        count += 0.3
                }
            }
            
            dispatcher.notify(queue: .main) {
                self.isProcessing = false
                return
            }
    }
    
    func decodeBoletim(qrCode: String) {
        
        let words : [String] = qrCode.split(separator: " ").map { (sequence) -> String in
            return sequence.description.replacingOccurrences(of: " ", with: "")
        }

        var boletim = BoletimVM(id: "", cUF: 0, cMum: 0, boletimDetalhes: [])

        boletim.id = "\(StringHelper.getWord(words: words, prefix: "IDUE"))-\(StringHelper.getWord(words: words, prefix: "UNFE"))-\(StringHelper.getWord(words: words, prefix: "MUNI"))-\(StringHelper.getWord(words: words, prefix: "ZONA"))-\(StringHelper.getWord(words: words, prefix: "SECA"))"
        boletim.cUF = StringHelper.getUF(words: words)
        boletim.cMum = StringHelper.getNumber(words: words, prefix: "MUNI")

        var cPartido: Int = 0
        var cCargo : Int = 0

        for word in words {
            
            let label : String = StringHelper.getLabelOfWord(word: word)
            let value : String = StringHelper.getValueOfWord(word: word)
            
            if label == "CARG" { cCargo = Int(value) ?? 0 }
            if label == "PART" { cPartido = Int(value) ?? 0 }

            var namePartido = ""
            let enumPartido = EnumPartido.allCases.first { (en) -> Bool in
                return en.rawValueExt == cPartido
            }
            
            if let e = enumPartido {
                namePartido = e.description
            } 

            var nameCargo = ""
            let enumCargo = EnumKindPolitical.allCases.first { (en) -> Bool in
                return en.rawValueExt == cCargo
            }
            
            if let e = enumCargo {
                nameCargo = e.description
            }
            
            if label.isNumeric  {
                boletim.boletimDetalhes.append(BoletimDetalheVM(
                                                    id: "\(boletim.id)-\(label)",
                                                    boletim: boletim ,
                                                    cPartido: cPartido,
                                                    namePartido: namePartido,
                                                    cCargo: cCargo,
                                                    nameCargo: nameCargo,
                                                    cCandidato: label.toInt,
                                                    qtdVoto: value.toInt,
                                                    idTransactionBlockchain: "",
                                                    isProcessado: false))
            }
        }
        self.boletim = boletim

        for enIt in EnumKindPolitical.allCases {
            
            var cargo = BoletimCargoVM(id: enIt.rawValueExt, name: enIt.description)
            cargo.boletimDetalhes = self.boletim.boletimDetalhes.filter { (b) -> Bool in
                
                return b.cCargo == cargo.id
            }
            
            if cargo.boletimDetalhes.count > 0 {
                self.boletim.boletimCargos.append(cargo)
            }

        }
    
        self.isAlreadyExists = BoletimManager.shared.get(self.boletim.id) != nil
        self.boletim.boletimDetalhes = self.boletim.boletimDetalhes
        self.qtdToProcess = self.boletim.boletimDetalhes.count
    }
    
}

struct BoletimVM : Identifiable{
    var id : String
    var cUF: Int
    var cMum: Int
    var boletimDetalhes : [BoletimDetalheVM] = []
    var boletimCargos : [BoletimCargoVM] = []
}

struct BoletimCargoVM: Identifiable {
    var id : Int
    var name : String
    var boletimDetalhes : [BoletimDetalheVM] = []
}

struct BoletimDetalheVM : Identifiable{
    var id : String
    var boletim : BoletimVM
    var cPartido: Int
    var namePartido : String
    var cCargo : Int
    var nameCargo : String
    var cCandidato: Int
    var qtdVoto: Int
    var idTransactionBlockchain: String
    var isProcessado: Bool

    init(id : String,  boletim : BoletimVM, cPartido: Int, namePartido : String, cCargo : Int, nameCargo : String, cCandidato: Int, qtdVoto: Int, idTransactionBlockchain: String, isProcessado: Bool) {
        self.id = id
        self.boletim = boletim
        self.cPartido = cPartido
        self.namePartido = namePartido
        self.cCargo = cCargo
        self.nameCargo = nameCargo
        self.cCandidato = cCandidato
        self.qtdVoto = qtdVoto
        self.idTransactionBlockchain = idTransactionBlockchain
        self.isProcessado = isProcessado
         

    }
}
