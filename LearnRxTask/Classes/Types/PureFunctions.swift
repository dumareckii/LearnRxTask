//
//  PureFunctions.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/21/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

//MARK: - Pure functions

@discardableResult
func configure<ValueType: AnyObject>(_ value: ValueType, action: (ValueType) -> ()) -> ValueType {
    action(value)
    
    return value
}

func identity<Value>(_ value: Value) -> Value {
    return value
}

