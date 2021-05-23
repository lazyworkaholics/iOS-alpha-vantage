//
//  Router.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

enum AppRouteState:String {
    
    case dashboardView
    case intradayView
    case dailyAdjView
    case settingsView
}

struct Router: RouterProtocol {
    
    static var sharedInstance:Router = Router()
    var rootNavigationController:UINavigationController?
    
    var dashboardViewModel:DashboardViewModel?
    var intradayViewModel:IntradayViewModel?
    var dailyAdjViewModel:DailyAdjViewModel?
    var settingsViewModel:SettingsViewModel?
    
    var currentRouteState:AppRouteState?
    
    mutating func appLaunch(_ window: UIWindow) {
        
        self.dashboardViewModel = DashboardViewModel.init()
        let dashboardViewController = DashboardViewController.initWithViewModel(self.dashboardViewModel!)
        
        self.rootNavigationController = UINavigationController(rootViewController: dashboardViewController)
        
        self.rootNavigationController?.navigationBar.barTintColor = UIColor.init(named: STRINGS.COLORS.NAV_COLOR)
        
        self.rootNavigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.init(named: STRINGS.COLORS.FONT_COLOR) as Any]

        
        window.tintColor = UIColor.init(named: STRINGS.COLORS.NAV_COLOR)
        window.rootViewController = self.rootNavigationController!
        window.makeKeyAndVisible()
        
        self.currentRouteState = AppRouteState.dashboardView
    }
    
    
}
