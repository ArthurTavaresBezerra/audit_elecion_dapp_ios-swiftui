//
//  EnumHelper.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 10/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation

protocol EnumSequence
{
    associatedtype T: RawRepresentable where T.RawValue == Int
    static func all() -> AnySequence<T>
}
extension EnumSequence
{
    static func all() -> AnySequence<T> {
        return AnySequence { return EnumGenerator() }
    }
}

private struct EnumGenerator<T: RawRepresentable>: IteratorProtocol where T.RawValue == Int {
    var index = 0
    mutating func next() -> T? {
        guard let item = T(rawValue: index) else {
            return nil
        }
        index += 1
        return item
    }
}
