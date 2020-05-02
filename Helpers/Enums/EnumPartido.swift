//
//  EnumPartido.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 10/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation


enum EnumPartido: Int {

    case REP=10
    case PP=11
    case PDT=12
    case PT=13
    case PTB=14
    case MDB=15
    case PSTU=16
    case PSL=17
    case REDE=18
    case PODE=19
    case PSC=20
    case PCB=21
    case PL=22
    case CID=23
    case DEM=25
    case DC=27
    case PRTB=28
    case PCO=29
    case NOVO=30
    case PMN=33
    case PMB=35
    case PTC=36
    case PSB=40
    case PV=43
    case PSDB=45
    case PSOL=50
    case PAT=51
    case PSD=55
    case PCdoB=65
    case AVNT=70
    case SOLI=77
    case UP=80
    case PROS=9

    public var rawValueExt : Int {
        return self.rawValue
    }
        
    var description: String {
      get {
        switch self {
            case .REP: return "REP"
            case .PP: return "PP"
            case .PDT: return "PDT"
            case .PT: return "PT"
            case .PTB: return "PTB"
            case .MDB: return "MDB"
            case .PSTU: return "PSTU"
            case .PSL: return "PSL"
            case .REDE: return "REDE"
            case .PODE: return "PODE"
            case .PSC: return "PSC"
            case .PCB: return "PCB"
            case .PL: return "PL"
            case .CID: return "CID"
            case .DEM: return "DEM"
            case .DC: return "DC"
            case .PRTB: return "PRTB"
            case .PCO: return "PCO"
            case .NOVO: return "NOVO"
            case .PMN: return "PMN"
            case .PMB: return "PMB"
            case .PTC: return "PTC"
            case .PSB: return "PSB"
            case .PV: return "PV"
            case .PSDB: return "PSDB"
            case .PSOL: return "PSOL"
            case .PAT: return "PAT"
            case .PSD: return "PSD"
            case .PCdoB: return "PCdoB"
            case .AVNT: return "AVNT"
            case .SOLI: return "SOLI"
            case .UP: return "UP"
            case .PROS: return "PROS"
            }
        }
    }
}

extension EnumPartido {
    static var allCases: [EnumPartido] {
        return [.REP, .PP, .PDT, .PT, .PTB, .MDB, .PSTU, .PSL, .REDE, .PODE, .PSC, .PCB, .PL, .CID, .DEM, .DC, .PRTB, .PCO, .NOVO, .PMN, .PMB, .PTC, .PSB, .PV, .PSDB, .PSOL, .PAT, .PSD, .PCdoB, .AVNT, .SOLI, .UP, .PROS]
    }
}
