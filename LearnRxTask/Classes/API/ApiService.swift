//
//  ApiService.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/14/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

// MARK: - Protocol

protocol ApiService {
    func signIn(with email: String, password: String) -> Bool
}

// MARK: - Implementation

class ApiServiceImplementation: ApiService {

    func signIn(with email: String, password: String) -> Bool {
        return true
    }

}

// MARK: - Factory

class ApiServiceFactory {
    static func `default`() -> ApiService {
        return ApiServiceImplementation()
    }
}
