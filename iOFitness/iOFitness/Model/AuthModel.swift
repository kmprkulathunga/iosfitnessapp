//
//  AuthModel.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation

struct AuthModel {
    let email: String
    let password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
