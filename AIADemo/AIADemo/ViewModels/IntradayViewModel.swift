//
//  IntradayViewModel.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

struct IntradayViewModel {
    
    //MARK:- variables and initializers
    var intradayProtocol: IntradayViewModelProtocol?
    var datasource: Search
    var router:RouterProtocol = Router.sharedInstance
    
    // MARK: - intraday functions
    init(_ search: Search) {
        
        datasource = search
    }
    
    func navigateToDashboard() {
        
        router.backToDashboard()
    }
}
