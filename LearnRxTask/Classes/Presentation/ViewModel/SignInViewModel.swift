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
               email: Driver<String>?,
               password: Driver<String>?,
               signInTaps: Driver<Void>?
          ),
          API: ApiService
     ) {
          validatedEmail = input.email! //TODO: unwrap
               .flatMapLatest {
                    Driver.of(SignInValidator.validateEmail(email: $0))
                         .asDriver(onErrorJustReturn: .failed(message: "Smth went wrong"))
               }
          

          validatedPassword = input.password!.flatMapLatest { //TODO: unwrap
               Driver.of(SignInValidator.validatePassword(password: $0)).asDriver(onErrorJustReturn: .failed(message: "Smth went wrong"))
          }

          signInEnabled = Driver.combineLatest(validatedEmail, validatedPassword) { email, password in
               return email.isValid && password.isValid
          }.distinctUntilChanged()

          let emailAndPassword = Driver
               .combineLatest(input.email!, input.password!) { ($0, $1) } //TODO: unwrap
          

          signedIn = input.signInTaps!
               .withLatestFrom(emailAndPassword)
               .flatMapLatest { email, password in
                    return  Driver.of(API.signIn(with: email, password: password)).asDriver(onErrorJustReturn: false)
               }
          
     }
}

