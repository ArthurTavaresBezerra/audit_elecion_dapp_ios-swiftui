//
//  StringHelper.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 09/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation

class StringHelper {
        
    public static func getLabelOfWord(word: String) -> String {
        let words = word.split(separator: ":").map { (str) -> String in
            return str.description
        }
        
        if words.count > 0 {
            return words[0]
        }
        
        return ""
    }

    public static func getValueOfWord(word: String) -> String {
        let words = word.split(separator: ":").map { (str) -> String in
            return str.description
        }
        
        if words.count >= 2 {
            return words[words.count-1]
        }
        
        return ""
    }


    public static func getWord(words: [String], prefix: String) -> String {

        if let word : String = words.first(where: { (str) -> Bool in
                return str.starts(with: prefix)
        }) {
            return getValueOfWord(word: word)
        }
        return ""
    }

    public static func getNumber(words: [String], prefix: String) -> Int {
        let possibleNumber : String = getWord(words: words, prefix: prefix)
        if possibleNumber.isNumeric{
            if let int = Int(possibleNumber){
                return int
            }
        }
        return 0
    }

    public static func getUF(words: [String]) -> Int{

        if let wordUF : String? = words.first(where: { (str) -> Bool in
                return str.starts(with: "UNFE")
        }) {
            let uf = EnumUF.allCases.filter({ (en) -> Bool in
                return en.description == getValueOfWord(word: wordUF!)
            })
            
            if (uf.count > 0){
                return uf[0].rawValue
            }
                
        }
        return 0
    }
}
