//
//  Reducer.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/27/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public struct Reducer<Value, Result> {
    
    public typealias Transform = (Result, Value) -> Result
    
    public let initial: Result
    public let transform: Transform
    
    public init(_ initial: Result, transform: @escaping Transform) {
        self.initial = initial
        self.transform = transform
    }
}

extension Sequence {
    
    func joined<Result>(_ reducer: Reducer<Element, Result>) -> Result {
        return self.reduce(reducer.initial, reducer.transform)
    }
}
