//
//  GreetingHelper.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation

class GreetingHelper {
    static func getCurrentTimePeriod() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if hour < 12 {
            return "Good Morning"
        } else if hour < 18 {
            return "Good Afternoon"
        } else {
            return "Good Evening"
        }
    }
    
    static func getCurrentMood() -> String {
        let currentTimePeriod = getCurrentTimePeriod()
        
        if currentTimePeriod == "Good Morning" {
            return "Happy"
        } else if currentTimePeriod == "Good Afternoon" {
            return "Energetic"
        } else {
            return "Relaxed"
        }
    }
}
