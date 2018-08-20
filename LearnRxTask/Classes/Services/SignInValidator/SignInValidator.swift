//
//  SignInValidator.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

struct SignInValidator {

    static func validateEmail(email: String) -> ValidationResult {

        let validationRules: [StringValidationRule] = [
                .charactersCountGreaterThanOrEqualTo(4),
                .shouldMatchWithRegExp("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        ]

        return validationRules
            .validate(string: email) ?
            .ok :
            .failed(message: "Email not valid")
    }

    static func validatePassword(password: String) -> ValidationResult {

        let validationRules: [StringValidationRule] = [.charactersCountGreaterThanOrEqualTo(6)]

        return validationRules
            .validate(string: password) ?
            .ok:
            .failed(message: "Password not valid")
    }
}
