//
//  AppDelegate.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appRouter:RouterProtocol = Router.sharedInstance
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        appRouter.appLaunch(window!)
        return true
    }

}

