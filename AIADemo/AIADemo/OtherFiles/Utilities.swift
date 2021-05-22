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
    
    func getInterval() -> String {
        
        guard let interval = UserDefaults.standard.string(forKey: STRINGS.USER_DEFAULTS_INTERVAL) else {
            
            UserDefaults.standard.setValue(STRINGS.FIFTEEN_MINS, forKey: STRINGS.USER_DEFAULTS_INTERVAL)
            return STRINGS.FIFTEEN_MINS
        }
        
        return interval
    }
    
    func getOutputSize() -> String {
        
        guard let outputsize = UserDefaults.standard.string(forKey: STRINGS.USER_DEFAULTS_OUTPUTSIZE) else {
            
            UserDefaults.standard.setValue(STRINGS.COMPACT, forKey: STRINGS.USER_DEFAULTS_OUTPUTSIZE)
            return STRINGS.COMPACT
        }
        
        return outputsize
    }
    
    func getAPIKey() -> String {
        // to be changed to keychain
        guard let apikey = UserDefaults.standard.string(forKey: STRINGS.KEYCHAIN_APIKEY) else {
            
            UserDefaults.standard.setValue(STRINGS.APIKEY_DEFAULT_VALUE, forKey: STRINGS.KEYCHAIN_APIKEY)
            return STRINGS.APIKEY_DEFAULT_VALUE
        }
        
        return apikey
    }
}
