//
//  WorkoutLevelExcersiseModel.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation

struct WorkoutLevelExcersiseModel {
    let name: String
    let description: String
    let reps: String
    let image: String
    let video: String
    
    init(name: String, description: String, reps: String, image: String, video: String) {
        self.name = name
        self.description = description
        self.reps = reps
        self.image = image
        self.video = video
    }
}
