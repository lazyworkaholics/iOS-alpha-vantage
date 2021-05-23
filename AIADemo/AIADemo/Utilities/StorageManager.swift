//
//  LocalStorageManager.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import Foundation

enum Interval:String {
    case ONE_MIN = "1min"
    case FIVE_MINS = "5min"
    case FIFTEEN_MINS = "15min"
    case THIRTY_MINS = "30min"
    case SIXTY_MINS = "60min"
}

enum OutputSize:String {
    case FULL = "full"
    case COMPACT = "compact"
}

struct StorageManager: StorageManagerProtocol {
    
    var userDefaults = UserDefaults.standard
    
    // MARK: - Handy functions
    func getInterval() -> String {
        
        guard let interval = userDefaults.string(forKey: STRINGS.USER_DEFAULTS_INTERVAL) else {
            
            userDefaults.setValue(STRINGS.FIFTEEN_MINS, forKey: STRINGS.USER_DEFAULTS_INTERVAL)
            return STRINGS.FIFTEEN_MINS
        }
        
        return interval
    }
    
    func setInterval(interval:Interval) {
        userDefaults.setValue(interval.rawValue, forKey: STRINGS.USER_DEFAULTS_INTERVAL)
    }
    
    func getOutputSize() -> String {
        
        guard let outputsize = userDefaults.string(forKey: STRINGS.USER_DEFAULTS_OUTPUTSIZE) else {
            
            userDefaults.setValue(STRINGS.COMPACT, forKey: STRINGS.USER_DEFAULTS_OUTPUTSIZE)
            return STRINGS.COMPACT
        }
        
        return outputsize
    }
    
    func setOutputSize(value:OutputSize) {
        userDefaults.setValue(value.rawValue, forKey: STRINGS.USER_DEFAULTS_OUTPUTSIZE)
    }
    
    func getAPIKey() -> String {
        // to be changed to keychain
        guard let apikey = userDefaults.string(forKey: STRINGS.KEYCHAIN_APIKEY) else {
            
            userDefaults.setValue(STRINGS.APIKEY_DEFAULT_VALUE, forKey: STRINGS.KEYCHAIN_APIKEY)
            return STRINGS.APIKEY_DEFAULT_VALUE
        }
        
        return apikey
    }
    
    func setAPIKey(key:String) {
        // to be changed to keychain
        userDefaults.setValue(key, forKey: STRINGS.KEYCHAIN_APIKEY)
    }
    
    func getDashboardData() -> [Search] {
    
        guard let dashboardData:[Search] = userDefaults.object(forKey: "dashboard_data") as? [Search] else {
            
            userDefaults.setValue([], forKey: "dashboard_data")
            return []
        }
        return dashboardData.reversed()
    }
    
    func saveToDashboardData( object:Search) -> [Search] {
    
        var dashboardData:[Search] = userDefaults.object(forKey: "dashboard_data") as? [Search] ?? []

        dashboardData.append(object)
        if dashboardData.count == 51 {
            dashboardData.remove(at: 0)
        }
        
        userDefaults.setValue(dashboardData, forKey: "dashboard_data")
        return dashboardData.reversed()
    }
    
    func deleteFromDashboardData( object:Search) -> [Search] {
        
        var dashboardData:[Search] = userDefaults.object(forKey: "dashboard_data") as? [Search] ?? []
        
        var index = 0
        for item in dashboardData {
            if item.symbol == object.symbol {
                break
            }
            index += 1
        }
        
        if index < dashboardData.count {
            dashboardData.remove(at: index)
        }

        userDefaults.setValue(dashboardData, forKey: "dashboard_data")
        return dashboardData.reversed()
    }
}
