//
//  Association.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation
import IDPCastable

class Association {
    
    typealias Policy = objc_AssociationPolicy

    let policy: Policy
    
    private var keyStorage: UInt8 = 0
    private var key: UnsafePointer<UInt8> {
        return UnsafePointer<UInt8>(UnsafeMutablePointer(&self.keyStorage))
    }
    
    private let lock = NSLock()
    
    init(policy: Policy) {
        self.policy = policy
    }
    
    func lazyGet<Value: AnyObject>(base: AnyObject, initialiser: () -> Value) -> Value {
        let get: () -> Value? = { self.get(base: base) }
        
        return get() ?? self.lock.do {
            get() ?? configure(initialiser()) {
                self.set(base: base, value: $0)
            }
        }
    }
    
    func set<Value: AnyObject>(base: AnyObject, value: Value) {
        objc_setAssociatedObject(base, self.key, value, self.policy)
    }
    
    func get<Value: AnyObject>(base: AnyObject) -> Value? {
        return objc_getAssociatedObject(base, self.key).flatMap(cast)
    }
}


