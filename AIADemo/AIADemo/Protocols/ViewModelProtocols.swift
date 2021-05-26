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
    
    func reloadData()
}

protocol DashboardViewModelProtocol: ViewModelProtocol {
    
    func hideCollectionView()
        
    func dismissSearchKeyboard()
    
    func clearSearchText()
    
    func isRightBarButtonHidden(isHidden:Bool) 
}

protocol DailyAdjViewModelProtocol: ViewModelProtocol {
    
    func setSegmentHeaders(titles:[String])
}
