//
//  AssociatedObjectHelper.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation
import IDPCastable

struct AssociatedObjectHelper {
    
    static func associatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, initialiser: () -> ValueType) -> ValueType {
        return objc_getAssociatedObject(base, key)
            .flatMap(cast)
            ?? configure(initialiser()) {
                objc_setAssociatedObject(base, key, $0, .OBJC_ASSOCIATION_RETAIN)
            }
    }
    
    static func associateObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, value: ValueType) {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    @discardableResult
    private static func configure<ValueType: AnyObject>(_ value: ValueType, action: (ValueType) -> ()) -> ValueType {
        action(value)
        return value
    }
}

