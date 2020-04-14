//
//  BoletimModel.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 11/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//
import Foundation
import RealmSwift
import web3

class BoletimDetalheModel: RealmSwift.Object,  Identifiable {
 
    
    @objc dynamic var id = ""
    @objc dynamic var cPartido: Int = 0
    @objc dynamic var namePartido : String = ""
    @objc dynamic var cCargo : Int = 0
    @objc dynamic var nameCargo : String = ""
    @objc dynamic var cCandidato: Int = 0
    @objc dynamic var qtdVoto: Int = 0
    @objc dynamic var idTransactionBlockchain: String = ""

    @objc dynamic var boletim : BoletimModel? = BoletimModel()

    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(det : BoletimDetalheVM, boletim : BoletimModel) {
        self.init()
        self.id = det.id
        self.boletim = boletim
        self.cPartido = det.cPartido
        self.namePartido = det.namePartido
        self.cCargo = det.cCargo
        self.nameCargo = det.nameCargo
        self.cCandidato = det.cCandidato
        self.qtdVoto = det.qtdVoto
        self.idTransactionBlockchain = det.idTransactionBlockchain
    }
    
    required convenience init?(det : BoletimDetalheModel) {
         self.init()
         self.id = det.id
         self.boletim = det.boletim
         self.cPartido = det.cPartido
         self.namePartido = det.namePartido
         self.cCargo = det.cCargo
         self.nameCargo = det.nameCargo
         self.cCandidato = det.cCandidato
         self.qtdVoto = det.qtdVoto
         self.idTransactionBlockchain = det.idTransactionBlockchain
    }
    
}
