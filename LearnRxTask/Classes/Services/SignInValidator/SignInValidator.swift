//
//  SignInValidator.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

enum ValidationResult {
    case ok
    case empty
    case failed(message: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

struct SignInValidator {

    static func validateEmail(email: String) -> ValidationResult {
        if email.count == 0 {
            return .empty
        } else if !(email.count >= 4) {
            return .failed(message: "Email too short")
        }

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        let isValidEmail = emailPredicate.evaluate(with: email)

        return isValidEmail ? .ok : .failed(message: "Email not valid")
    }

    static func validatePassword(password: String) -> ValidationResult {
        if password.count == 0 {
            return .empty
        } else if !(password.count >= 6) {
            return .failed(message: "Password too short")
        }

        return .ok
    }
}
