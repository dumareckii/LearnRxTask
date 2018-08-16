//
//  ValidationCombinator.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/16/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

enum StringValidationRule {
    
    case charactersCountЕqualTo(number: Int)
    case charactersCountGreaterThan(number: Int)
    case charactersCountLessThan(number: Int)
    case shouldMatchWithRegExp(regExp: String)
}

extension Array where Array.Element: StringValidationRule {
    func checkForCompliance() -> Bool {
        
    }
}

enum ValidationResult {
    case ok
    case failed(message: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        case .failed(let _):
            return true
        }
    }
}

struct ValidationCombinator {
    
    func combine(validationRules: [ValidationRule]) -> Bool {
        return true
    }
}
