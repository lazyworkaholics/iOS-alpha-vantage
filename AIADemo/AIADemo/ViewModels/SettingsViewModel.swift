//
//  SettingsViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

struct SettingsViewModel {
    
    //MARK:- variables and initializers
    var router:RouterProtocol = Router.sharedInstance
    
    // MARK: - settings custom functions
    func navigateToDashboard() {
        
        router.backToDashboard()
    }
    
    func getOutputSizeSegmentIndex() -> Int{
        
        let outputsize = StorageManager.init().getOutputSize()
        if outputsize == STRINGS.COMPACT {
            return 0
        } else {
            return 1
        }
    }
    
    func setOutputSize(index:Int) {
        
        if index == 0 {
            StorageManager.init().setOutputSize(value: .COMPACT)
        } else {
            StorageManager.init().setOutputSize(value: .COMPACT)
        }
    }
    
    func getIntervalSegmentIndex() -> Int{
        
        let interval = StorageManager.init().getInterval()
        
        switch interval {
        case .ONE_MIN:
            return 0
        case .FIVE_MINS:
            return 1
        case .FIFTEEN_MINS:
            return 2
        case .THIRTY_MINS:
            return 3
        default:
            return 4
        }
    }
    
    func setInterval(index:Int) {
        switch index {
        case 0:
            StorageManager.init().setInterval(interval: .ONE_MIN)
            break
        case 1:
            StorageManager.init().setInterval(interval: .FIVE_MINS)
            break
        case 2:
            StorageManager.init().setInterval(interval: .FIFTEEN_MINS)
            break
        case 3:
            StorageManager.init().setInterval(interval: .THIRTY_MINS)
            break
        default:
            StorageManager.init().setInterval(interval: .SIXTY_MINS)
            break
        }
    }
    
    func getapikeyText() -> String {
        return StorageManager.init().getAPIKey()
    }
    
    func setAPIKey(key:String) {
        StorageManager.init().setAPIKey(key: key)
    }
}
