//
//  ViewModelProtocols.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

@objc protocol ViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String)
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    @objc optional func showDoubleActionAlert(_ title: String, message: String?, firstTitle:String, secondTitle:String?, onfirstClick:@escaping (() -> Void), onSecondClick:(() -> Void)?)
}

protocol DashboardViewModelProtocol: ViewModelProtocol {
    
}

protocol IntradayViewModelProtocol: ViewModelProtocol {
    
}

protocol DailyAdjViewModelProtocol: ViewModelProtocol {
    
}

protocol SettingsViewModelProtocol: ViewModelProtocol {
    
}