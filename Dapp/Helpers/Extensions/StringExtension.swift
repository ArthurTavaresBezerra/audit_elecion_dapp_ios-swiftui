//
//  StringExtension.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 09/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation


extension String {
    
    var isNumeric : Bool {
        return NumberFormatter().number(from: self) != nil
    }
    
    var toInt : Int {
        if let int = Int(self)  {
            return int
        }
        return 0
    }

}
