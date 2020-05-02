//
//  BoletimModel.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 11/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation
import RealmSwift

infix operator <-

class BoletimModel: RealmSwift.Object {

    @objc dynamic var id = ""
    @objc dynamic var cUF: Int = 0
    @objc dynamic var UF: String = ""
    @objc dynamic var cMun: Int = 0

    var boletimDetalhes = List<BoletimDetalheModel>()

    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(bol : BoletimVM) {
        self.init()
        self.id = bol.id
        self.cUF = bol.cUF
        self.cMun = bol.cMum

         let UFenum = EnumUF.allCases.first { (en) -> Bool in
            return en.rawValueExt == self.cUF
         }
         
         if let e = UFenum {
            self.UF = e.description
         }
    }

    required convenience init?(bol : BoletimModel) {
        self.init()
        self.id = bol.id
        self.cUF = bol.cUF
        self.cMun = bol.cMun
        self.UF = bol.UF
    }
}
