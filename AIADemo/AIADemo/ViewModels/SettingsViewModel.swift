//
//  SettingsViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

struct SettingsViewModel {
    
    //MARK:- variables and initializers
    var router:RouterProtocol!
    var storageManager:StorageManagerProtocol!
    
    init() {
        
        router = Router.sharedInstance
        storageManager = StorageManager.init()
    }
    
    // MARK: - settings custom functions
    func routeToDashboard() {
        
        router.backToDashboard()
    }
    
    func getOutputSizeSegmentIndex() -> Int {
        
        let outputsize = storageManager.getOutputSize()
        if outputsize == STRINGS.COMPACT {
            return 0
        }
        return 1
    }
    
    func setOutputSize(index:Int) {
        
        if index == 0 {
            storageManager.setOutputSize(value: .COMPACT)
        } else {
            storageManager.setOutputSize(value: .FULL)
        }
    }
    
    func getIntervalSegmentIndex() -> Int{
        
        let interval = storageManager.getInterval()
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
            storageManager.setInterval(interval: .ONE_MIN)
            break
        case 1:
            storageManager.setInterval(interval: .FIVE_MINS)
            break
        case 2:
            storageManager.setInterval(interval: .FIFTEEN_MINS)
            break
        case 3:
            storageManager.setInterval(interval: .THIRTY_MINS)
            break
        default:
            storageManager.setInterval(interval: .SIXTY_MINS)
            break
        }
    }
    
    func getapikeyText() -> String {
        return storageManager.getAPIKey()
    }
    
    func setAPIKey(key:String) {
        storageManager.setAPIKey(key: key)
    }
}
