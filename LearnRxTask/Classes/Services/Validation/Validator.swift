//
//  Validator.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/27/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public enum Validator {

    public typealias F<Value> = (Value) -> Bool
    public typealias Comparator<Value> = (Value, Value) -> Bool

    static func count(_ comparator: @escaping Comparator<Int>, _ count: Int) -> (String) -> Bool {
        return { comparator($0.count, count) }
    }

    static func regex(_ regex: String) -> (String) -> Bool {
        return { NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: $0) }
    }

    static func charactersInSet(_ characterSet: CharacterSet) -> (String) -> Bool {
        return { CharacterSet(charactersIn: $0).isStrictSubset(of: characterSet) }
    }
}
