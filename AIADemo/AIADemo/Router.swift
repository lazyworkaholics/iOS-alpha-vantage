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
        
        UINavigationBar.appearance().tintColor = UIColor.init(named: STRINGS.Colors.APP_COLOR)
        self.rootNavigationController = UINavigationController(rootViewController: dashboardViewController)
       
        window.tintColor = UIColor.init(named: STRINGS.Colors.APP_COLOR)
        window.rootViewController = self.rootNavigationController!
        window.makeKeyAndVisible()
        
//        self.listViewModel!.fetch()
        self.currentRouteState = AppRouteState.dashboardView
    }
    
    
}
