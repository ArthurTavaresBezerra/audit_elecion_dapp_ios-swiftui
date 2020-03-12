//
//  EnumCargoPolitico.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 08/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation


//Presidente=1, Governador=3, Senador=5, Deputado federal6Deputado estadual7Deputado distrital8Conselheiro distrital9Prefeito11Vereador13
    



enum EnumKindPolitical: Int, CustomStringConvertible {

    case  Presidente=1
    case  Governador=3
    case  Senador=5
    case  DeputadoFederal=6
    case  DeputadoEstadual=7
    case  DeputadoDistrital=8
    case  ConselheiroDistrital=9
    case  Prefeito=11
    case  Vereador=13


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

