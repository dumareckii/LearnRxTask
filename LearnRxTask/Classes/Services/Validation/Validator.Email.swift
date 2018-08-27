//
//  Validator.Email.swift
//  LearnRxTask
//
//  Created by Valentyn.D on 8/27/18.
//  Copyright © 2018 IDAP. All rights reserved.
//

import Foundation

extension Validator {
    
    public enum Email {
        
        static let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        static func validate(_ email: String) -> Result {
            let rules: [(F<String>, String)]  = [
                (count(>, 5), "Email should be longer, than 5 symbols."),
                (Validator.regex(regex), "Email should be of format x@x.x.")
            ]
            
            return rules
                .map(Result.lift)
                .map { $0(email)  }
                .joined(Reducer.concatenate())
        }
    }
}
