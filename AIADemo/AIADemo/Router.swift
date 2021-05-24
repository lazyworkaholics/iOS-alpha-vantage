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

class Router: RouterProtocol {
    
    static var sharedInstance:Router = Router()
    var rootNavigationController:UINavigationController?
    
    var dashboardViewModel:DashboardViewModel?
    var intradayViewModel:IntradayViewModel?
    var dailyAdjViewModel:DailyAdjViewModel?
    var settingsViewModel:SettingsViewModel?
    
    var currentRouteState:AppRouteState?
    
    func appLaunch(_ window: UIWindow) {
        
        self.dashboardViewModel = DashboardViewModel.init()
        let dashboardViewController = DashboardViewController.initWithViewModel(self.dashboardViewModel!)
        self.rootNavigationController = UINavigationController(rootViewController: dashboardViewController)
        
        self.rootNavigationController?.navigationBar.barTintColor = UIColor.init(named: STRINGS.COLORS.NAV_COLOR)
        window.tintColor = UIColor.black
        
        window.rootViewController = self.rootNavigationController!
        window.makeKeyAndVisible()
        
        self.currentRouteState = AppRouteState.dashboardView
    }
    
    func navigateToIntraday(with search:Search) {
        
        if self.currentRouteState == .dashboardView {
            DispatchQueue.main.async(execute: {() -> Void in
                
                let intradayViewModel = IntradayViewModel.init(search)
                let viewcontroller = IntradayViewController.initWithViewModel(intradayViewModel)
                self.rootNavigationController?.pushViewController(viewcontroller, animated: true)
                
                self.currentRouteState = .intradayView
            })
        }
    }
    
    func navigateToDailyAdj(with search:[Search]) {
        
        if self.currentRouteState == .dashboardView {
            DispatchQueue.main.async(execute: {() -> Void in
                
                let dailyAdjViewModel = DailyAdjViewModel.init(search)
                let viewcontroller = DailyAdjViewController.initWithViewModel(dailyAdjViewModel)
                self.rootNavigationController?.pushViewController(viewcontroller, animated: true)
                
                self.currentRouteState = .dailyAdjView
            })
        }
    }
    
    func navigateToSettings() {
        
        if self.currentRouteState == .dashboardView {
            DispatchQueue.main.async(execute: {() -> Void in
                
                let settingViewModel = SettingsViewModel.init()
                let viewcontroller = SettingsViewController.initWithViewModel(settingViewModel)
                let navigationController2 = UINavigationController.init(rootViewController: viewcontroller)
                navigationController2.navigationBar.barTintColor = UIColor.init(named: STRINGS.COLORS.NAV_COLOR)
                self.rootNavigationController?.present(navigationController2, animated: true, completion: nil)
            })
        }
        self.currentRouteState = .settingsView
    }
    
    func backToDashboard() {
        
        if self.currentRouteState == .intradayView || self.currentRouteState == .dailyAdjView {
            DispatchQueue.main.async(execute: {() -> Void in
                
                self.rootNavigationController?.popViewController(animated: true)
                self.currentRouteState = .dashboardView
            })
        } else if self.currentRouteState == .settingsView {
            DispatchQueue.main.async(execute: {() -> Void in
                
                self.rootNavigationController?.topViewController?.dismiss(animated: true, completion: nil)
                self.currentRouteState = .dashboardView
            })
        }
    }
    
    
}
