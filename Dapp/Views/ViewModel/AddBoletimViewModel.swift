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

    let dogApiUrl = "https://dog.ceo/api/breeds/list/random/40"
    private var task: AnyCancellable?
    
    @Published var isProcessing: Bool = false
    @Published var dogs: [String] = []
    @Published var boletim : BoletimVM = BoletimVM(id: "", cUF: 0, cMum: 0, boletimDetalhes: [])
    
    func fetchDogs() {
      task = URLSession.shared.dataTaskPublisher(for: URL(string: dogApiUrl)!)
        .map { $0.data }
        .decode(type: DogMessage.self, decoder: JSONDecoder())
        .map { $0.message }
        .replaceError(with: [String]())
        .eraseToAnyPublisher()
        .receive(on: RunLoop.main)
        .assign(to: \AddBoletimViewModel.dogs, on: self)
    }
    
    func saveLocalAndBlockChain(){
        self.isProcessing.toggle()
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
            
            if label.isNumeric  {
                boletim.boletimDetalhes.append(BoletimDetalheVM(
                                                    id: "\(boletim.id)-\(label)",
                                                    boletim: boletim ,
                                                    cPartido: cPartido,
                                                    namePartido: namePartido,
                                                    cCargo: cCargo,
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
    }
}

struct DogMessage: Codable {
  let message: [String]
  let status: String
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
    var cCandidato: Int
    var qtdVoto: Int
    var idTransactionBlockchain: String
    var isProcessado: Bool
}
