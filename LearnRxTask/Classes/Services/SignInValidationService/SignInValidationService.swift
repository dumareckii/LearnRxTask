//
//  SignInValidationService.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum ValidationResult {
    case Ok
    case Empty
    case Failed(message: String)
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .Ok:
            return true
        default:
            return false
        }
    }
}

// MARK: Protocol

protocol SignInValidationService {
    func validateEmail(email: String) -> Observable<ValidationResult>
    func validatePassword(password: String) -> Observable<ValidationResult>
}

// MARK: Implementation

class SignInValidationServiceImplementation: SignInValidationService {

    func validateEmail(email: String) -> Observable<ValidationResult> {
        if email.count == 0 {
            return Observable.just(.Empty)
        } else if !(email.count >= 4) {
            return Observable.just(.Failed(message: "Email too short"))
        }

        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        let isValidEmail = emailPredicate.evaluate(with: email)

        return isValidEmail ? Observable.just(.Ok) : Observable.just(.Failed(message: "Email not valid"))
    }

    func validatePassword(password: String) -> Observable<ValidationResult> {
        if password.count == 0 {
            return Observable.just(.Empty)
        } else if !(password.count >= 6) {
            return Observable.just(.Failed(message: "Password too short"))
        }

        return Observable.just(.Ok)
    }
}

// MARK: Factory

class SignInValidationServiceFactory {
    static func `default`() -> SignInValidationService {
        return SignInValidationServiceImplementation()
    }
}
