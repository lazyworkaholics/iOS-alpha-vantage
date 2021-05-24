//
//  DailyAdjViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

struct DailyAdjViewModel {
    
    //MARK:- variables and initializers
    var dailyAdjProtocol: DailyAdjViewModelProtocol?
    var datasource: Search
    var router:RouterProtocol = Router.sharedInstance
    
    // MARK: - daily adj functions
    init(_ search: Search) {
        
        datasource = search
    }
    
    func navigateToDashboard() {
        
        router.backToDashboard()
    }
}
