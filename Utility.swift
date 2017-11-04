//
//  Utility.swift
//  rainyshinecloudy
//
//  Created by robimolte on 04/11/2017.
//  Copyright © 2017 myself. All rights reserved.
//

import Foundation

class Utility {
    
    static func kelvinToFareneith(temp: Double) -> Double {
        let kelvinToFarenheitPreDivision = (temp * (9/5) - 459.67)
        let kelvinToFarenheit = Double(round(10*kelvinToFarenheitPreDivision/10))
        return kelvinToFarenheit
    }
    
    static func dayOfTheWeek(unixConverterDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: unixConverterDate)
        var dayOfTheWeek = dateString.components(separatedBy: " ")
        if dayOfTheWeek.count > 0 {
            return dayOfTheWeek[0]
        }
        else {
            return ""
        }
    }
}
