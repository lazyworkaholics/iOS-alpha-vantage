//
//  SettingsViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

struct SettingsViewModel {
    
    //MARK:- variables and initializers
    var settingsProtocol: SettingsViewModelProtocol?
    var router:RouterProtocol = Router.sharedInstance
    
    // MARK: - settings custom functions
    func navigateToDashboard() {
        
        router.backToDashboard()
    }
}
