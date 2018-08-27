//
//  NSLocking+Extensions.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/27/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

public extension NSLocking {
    
    public func `do`<Result>(_ execute: () -> Result) -> Result {
        self.lock()
        defer { self.unlock() }
        
        return execute()
    }
}
