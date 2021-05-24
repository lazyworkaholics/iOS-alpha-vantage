//
//  ViewModelProtocols.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import Foundation

@objc protocol ViewModelProtocol {
    
    @objc optional func showStaticAlert(_ title: String, message: String)
    @objc optional func showLoadingIndicator()
    @objc optional func hideLoadingIndicator()
    
    @objc optional func showDoubleActionAlert(_ title: String, message: String?, firstTitle:String, secondTitle:String?, onfirstClick:@escaping (() -> Void), onSecondClick:(() -> Void)?)
}

protocol DashboardViewModelProtocol: ViewModelProtocol {
    
    func showCollectionView()
    
    func hideCollectionView()
    
    func displaySearch(controller:SearchDisplayViewController)
    
    func hideSearch(controller:SearchDisplayViewController)
    
    func dismissSearchKeyboard()
    
    func clearSearchText()
}

protocol IntradayViewModelProtocol: ViewModelProtocol {
    
    func showTableView()
}

protocol DailyAdjViewModelProtocol: ViewModelProtocol {
    
}

protocol SettingsViewModelProtocol: ViewModelProtocol {
    
}
