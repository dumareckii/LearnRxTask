//
//  AssociatedObjectHelper.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation
import IDPCastable

//return objc_getAssociatedObject(base, key)
//    .flatMap(cast)
//    ?? call {
//        configure(associated) { objc_setAssociatedObject(base, key, $0, .OBJC_ASSOCIATION_RETAIN) }
//}

//return objc_getAssociatedObject(base, key).flatMap { cast($0) } ?? configure(initialiser, action: { (vt) -> (ValueType) in
//    objc_setAssociatedObject(base, key, vt, .OBJC_ASSOCIATION_RETAIN)
//    return vt
//})

struct AssociatedObjectHelper {
    
    static func associatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, initialiser: () -> ValueType) -> ValueType {
        return objc_getAssociatedObject(base, key).flatMap { return cast($0) } ?? configure(initialiser) {
            objc_setAssociatedObject(base, key, $0, .OBJC_ASSOCIATION_RETAIN)
            return $0
        }
    }
    
    static func associateObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, value: ValueType) {
        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
    }
    
    private static func configure<ValueType: AnyObject>(_ initialiser: () -> ValueType, action: (ValueType) -> (ValueType)) -> ValueType {
        return action(initialiser())
    }
    
//    static func associatedObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, initialiser: () -> ValueType) -> ValueType {
//        return objc_getAssociatedObject(base, key).flatMap { return cast($0) } ?? configure(initialiser) { objc_setAssociatedObject(base, key, $0, .OBJC_ASSOCIATION_RETAIN) }
//    }
//
//    static func associateObject<ValueType: AnyObject>(base: AnyObject, key: UnsafePointer<UInt8>, value: ValueType) {
//        objc_setAssociatedObject(base, key, value, .OBJC_ASSOCIATION_RETAIN)
//    }
//
//    private static func configure<ValueType: AnyObject>(_ initialiser: () -> ValueType, action: (ValueType) -> ()) -> ValueType {
//        let assotiated = initialiser()
//        action(assotiated)
//        return assotiated
//    }
}

