//
//  EnumCargoPolitico.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 08/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation


enum EnumKindPolitical: Int {
    
    case  Presidente=1
    case  Governador=3
    case  Senador=5
    case  DeputadoFederal=6
    case  DeputadoEstadual=7
    case  DeputadoDistrital=8
    case  ConselheiroDistrital=9
    case  Prefeito=11
    case  Vereador=13

    public var rawValueExt : Int {
        return self.rawValue
    }
    
    var description: String {
      get {
          switch self {
            case .Presidente:
              return "Presidente"
            case .Governador:
              return "Governador"
            case .Senador:
              return "Senador"
            case .DeputadoFederal:
              return "Deputado Federal"
            case .DeputadoEstadual:
              return "Deputado Estadual"
            case .DeputadoDistrital:
              return "Deputado Distrital"
            case .ConselheiroDistrital:
              return "Conselheiro Distrital"
            case .Prefeito:
              return "Prefeito"
            case .Vereador:
              return "Vereador"
          }
      }
    }

}

extension EnumKindPolitical {
    static var allCases: [EnumKindPolitical] {
        return [.Presidente, .Governador, .Senador, .DeputadoFederal, .DeputadoEstadual, .DeputadoDistrital, .ConselheiroDistrital, .Prefeito, .Vereador]
    }
}
 
