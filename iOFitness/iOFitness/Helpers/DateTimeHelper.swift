//
//  DateTimeHelper.swift
//  iOFitness
//
//  Created by ShitOS on 2023-05-30.
//

import Foundation

class DateTimeHelper {
    
    let getCurrentDateTime: String = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd:HH:mm:ss"
        let dateTimeNow = dateFormatter.string(from: Date())
        return dateTimeNow
    }()
    
    func convertDateTimePicker(_ dateTime: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDateTime = dateFormatter.string(from: dateTime)
        return formattedDateTime
    }
}
