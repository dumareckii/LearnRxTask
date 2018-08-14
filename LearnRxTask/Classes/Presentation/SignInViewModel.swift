//
//  SignInViewModel.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class SignInViewModel {

     let validatedEmail: Driver<ValidationResult>
     let validatedPassword: Driver<ValidationResult>

     let signInEnabled: Driver<Bool>
     let signedIn: Driver<Bool>

     init(
          input: (
               email: Driver<String>,
               password: Driver<String>,
               signInTaps: Driver<Void>
          ),
          dependency: (
               API: ApiService,
               validationService: SignInValidationService
          )
     ) {
          validatedEmail = input.email.flatMapLatest {
               return dependency.validationService.validateEmail(email: $0).asDriver(onErrorJustReturn: .Failed(message: "Smth went wrong"))
          }.debug("email validation")

          validatedPassword = input.password.flatMapLatest {
               return dependency.validationService.validatePassword(password: $0).asDriver(onErrorJustReturn: .Failed(message: "Smth went wrong"))
          }.debug("password validation")

          signInEnabled = Driver.combineLatest(validatedEmail, validatedPassword) { email, password in
               return email.isValid && password.isValid
          }.distinctUntilChanged().debug("signInEnabled validation")

          let emailAndPassword = Driver.combineLatest(input.email, input.password) { ($0, $1) }.debug("combine email and password")

          signedIn = input.signInTaps.withLatestFrom(emailAndPassword).flatMapLatest({ (email, password) in
               return dependency.API.signIn(with: email, password: password).asDriver(onErrorJustReturn: false)
          }).debug("is signed in")
     }
}

