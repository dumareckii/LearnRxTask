//
//  ApiService.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


// MARK: Protocol

protocol ApiService {
    func signIn(with username: String, password: String) -> Observable<Bool>
}

// MARK: Implementation

class ApiServiceImplementation: ApiService {

    func signIn(with username: String, password: String) -> Observable<Bool> {
        return Observable.just(true)
    }

}

// MARK: Factory

class ApiServiceFactory {
    static func `default`() -> ApiService {
        return ApiServiceImplementation()
    }
}
