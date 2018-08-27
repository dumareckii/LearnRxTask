//
//  Validator.Password.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/27/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Validator {
    
    public enum Password {
        
        static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        static func validate(_ password: String) -> Result {
            let rules: [(F<String>, String)]  = [
                (count(>, 8), "Password should be longer, than 8 symbols."),
                (Validator.charactersInSet(
                    CharacterSet.lowercaseLetters.union(CharacterSet.decimalDigits)
                ),
                 "Email should be of format x@x.x.")
            ]
            
            return rules
                .map(Result.lift)
                .map { $0(password)  }
                .joined(Reducer.concatenate())
        }
    }
}
