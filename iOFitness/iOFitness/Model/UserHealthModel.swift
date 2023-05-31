//
//  UserHealthModel.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation

struct UserHealthModel {
    let height: Double
    let weight: Double
    let age: Int
    let gender: String
    let fitnessGoal: String
    let updated: String
    
    init(height: Double, weight: Double, age: Int, gender: String, fitnessGoal: String, updated: String) {
        self.height = height
        self.weight = weight
        self.age = age
        self.gender = gender
        self.fitnessGoal = fitnessGoal
        self.updated = updated
    }
}

