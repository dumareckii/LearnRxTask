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

//MARK: - Protocol

protocol SignInViewModel {
     func signIn(withEmail email: String, password: String) -> Observable<Bool>
}

//MARK: - Implementation

class SignInViewModelImplementation: SignInViewModel {

     private let apiService: ApiService

     init(apiService: ApiService) {
          self.apiService = apiService
     }
     
     func signIn(withEmail email: String, password: String) -> Observable<Bool> {
          return Observable
               .of(apiService
                    .signIn(with: email, password: password)
               )
     }
}

// MARK: Factory

class SignInViewModelFactory {
     static func `default`() -> SignInViewModel {
          return SignInViewModelImplementation(apiService: ApiServiceFactory.default())
     }
}

