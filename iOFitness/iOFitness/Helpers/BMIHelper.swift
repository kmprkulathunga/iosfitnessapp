//
//  BMIHelper.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation

class BMIHelper {
    
    // Calculate BMI
    func calculateBMI(height: Double, weight: Double) -> String {
        let heightInMeters = height / 100
        let bmi = weight / (heightInMeters * heightInMeters)
        let formattedBMI = String(format: "%.1f", bmi)
        return formattedBMI
    }
    
    // Get BMI status
    func getBMIStatus(bmiValue: String) -> String {
        let bmi = Double(bmiValue) ?? 0.0
        
        if bmi < 18.5 {
            return "Underweight"
        } else if bmi < 25 {
            return "Normal"
        } else if bmi < 30 {
            return "Overweight"
        } else {
            return "Obese"
        }
    }
    
}
