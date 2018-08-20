//
//  StringValidation.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/16/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit

enum StringValidationRule {
    case charactersCountЕqualTo(Int)
    case charactersCountGreaterThan(Int)
    case charactersCountGreaterThanOrEqualTo(Int)
    case charactersCountLessThan(Int)
    case charactersCountLessThanOrEqualTo(Int)
    case shouldMatchWithRegExp(String)

}

extension Array where Element == StringValidationRule {
    func validate(string: String) -> Bool {
        let validationResults = self.map { check($0, string) }
        let isValid = validationResults.reduce(true, { $0 && $1 })

        return isValid
    }

    private func check(_ rule: StringValidationRule, _ string: String) -> Bool {
        switch rule {
        case .charactersCountЕqualTo(let number):
            return string.count == number
        case .charactersCountGreaterThan(let number):
            return string.count > number
        case .charactersCountGreaterThanOrEqualTo(let number):
            return string.count >= number
        case .charactersCountLessThan(let number):
            return string.count < number
        case .charactersCountLessThanOrEqualTo(let number):
            return string.count <= number
        case .shouldMatchWithRegExp(let regExp):
            return NSPredicate(format: "SELF MATCHES %@", regExp).evaluate(with: string)
        }
    }
}


