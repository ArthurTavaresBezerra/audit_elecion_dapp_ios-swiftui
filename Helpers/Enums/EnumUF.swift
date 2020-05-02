//
//  EnumUF.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 09/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation


enum EnumUF : Int, CustomStringConvertible, CaseIterable {
    case RO=11
    case AC=12
    case AM=13
    case RR=14
    case PA=15
    case AP=16
    case TO=17
    case MA=21
    case PI=22
    case CE=23
    case RN=24
    case PB=25
    case PE=26
    case AL=27
    case SE=28
    case BA=29
    case MG=31
    case ES=32
    case RJ=33
    case SP=35
    case PR=41
    case SC=42
    case RS=43
    case MS=50
    case MT=51
    case GO=52
    case DF=53
    
    
    public var rawValueExt : Int {
        return self.rawValue
    }
    
    var description: String {
      get {
        switch self {
            case .RO: return "RO"
            case .AC: return "AC"
            case .AM: return "AM"
            case .RR: return "RR"
            case .PA: return "PA"
            case .AP: return "AP"
            case .TO: return "TO"
            case .MA: return "MA"
            case .PI: return "PI"
            case .CE: return "CE"
            case .RN: return "RN"
            case .PB: return "PB"
            case .PE: return "PE"
            case .AL: return "AL"
            case .SE: return "SE"
            case .BA: return "BA"
            case .MG: return "MG"
            case .ES: return "ES"
            case .RJ: return "RJ"
            case .SP: return "SP"
            case .PR: return "PR"
            case .SC: return "SC"
            case .RS: return "RS"
            case .MS: return "MS"
            case .MT: return "MT"
            case .GO: return "GO"
            case .DF: return "DF"
        }
      }
    }
}
