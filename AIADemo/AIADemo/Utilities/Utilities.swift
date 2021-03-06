//
//  Utilities.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 21/05/2021.
//

import Foundation

struct Utilities {
    
    // MARK: - Handy functions
    func getDate(_ dateString:String, timeZone: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone =  TimeZone.init(identifier: timeZone)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var date = dateFormatter.date(from: dateString)
        if date == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            date = dateFormatter.date(from: dateString)
        }
        return date
    }
}
