//
//  ValidationResult.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/20/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

extension Validator {
    
    public enum Result {
        case ok
        case failed(message: String)
        
        static func lift<Value>(_ validator: @escaping F<Value>, description: String) -> (Value) -> Result {
            return { validator($0) ? .ok : .failed(message: description) }
        }
        
        public var isValid: Bool {
            switch self {
            case .ok: return true
            case .failed: return false
            }
        }
        
        public var message: String? {
            switch self {
            case .ok: return nil
            case let .failed(message): return message
            }
        }
        
        public func join(_ result: Validator.Result) -> Validator.Result {
            switch (self, result) {
            case (.ok, .ok):
                return .ok
                
            default:
                return .failed(message:
                    [self.message, result.message]
                    .flatMap(identity)
                    .joined(separator: " ")
                )
            }
        }
    }
}

extension Reducer where Value == Validator.Result, Result == Validator.Result {
    
    static func concatenate() -> Reducer {
        return self.init(.ok) { $0.join($1) }
    }
}

extension Reducer where Value == Bool, Result == Bool {
    
    static func and() -> Reducer {
        return self.init(true) { $0 && $1 }
    }
    
    static func or() -> Reducer {
        return self.init(false) { $0 || $1 }
    }
}
