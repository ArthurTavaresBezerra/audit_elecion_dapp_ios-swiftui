//
//  PListHelper.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 10/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation

class PListHelper {
    

    public static func readProperty(_ property: String) -> String {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: AnyObject] = [:] //Our data
        let plistPath: String? = Bundle.main.path(forResource: "Info", ofType: "plist")! //the path of the data
        let plistXML = FileManager.default.contents(atPath: plistPath!)!
        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML,
                                                                   options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]
            
            if let index = plistData.index(forKey: property) {
                let row = plistData[index]
                return row.value as? String ?? ""
            }

        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
        return ""
    }
}
