//
//  ValidationResult.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/20/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

enum ValidationResult {
    case ok
    case failed(message: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        case .failed:
            return false
        }
    }
}
