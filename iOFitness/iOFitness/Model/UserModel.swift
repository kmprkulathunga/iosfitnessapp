//
//  UserModel.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation

struct UserModel {
    // Account
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    
    // Health
    let height: Double
    let weight: Double
    let age: Int
    let gender: String
    let fitnessGoal: String
    
    // Changes
    let created: String
    let updated: String
    
    
    init(firstName: String, lastName: String, email: String, password: String, height: Double, weight: Double, age: Int, gender: String, fitnessGoal: String, created: String, updated: String) {
        
        // Account
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        
        // Health
        self.height = height
        self.weight = weight
        self.age = age
        self.gender = gender
        self.fitnessGoal = fitnessGoal
        
        // Changes
        self.created = created
        self.updated = updated
    }
}
