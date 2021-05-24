//
//  RouterProtocol.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

protocol RouterProtocol {
    
    func appLaunch(_ window:UIWindow)
    
    func navigateToIntraday(with search:Search)
    
    func navigateToDailyAdj(with searches:[Search])
    
    func navigateToSettings()
    
    func backToDashboard()
}
