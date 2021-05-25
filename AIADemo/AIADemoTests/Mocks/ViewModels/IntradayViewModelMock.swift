//
//  IntradayViewModelMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import Foundation
@testable import AIADemo

class IntradayViewModelMock: IntradayViewModelProtocol {
    
    var is_showTableView_called = false
    var is_showLoadingIndicator_Called = false
    var is_hideLoadingIndicator_Called = false
    var is_showStaticAlert_Called = false
    var is_showDoubleActionAlert_Called = false
    
    func showLoadingIndicator() {
        is_showLoadingIndicator_Called = true
    }
    
    func hideLoadingIndicator() {
        is_hideLoadingIndicator_Called = true
    }
    
    @objc func showStaticAlert(_ title: String, message: String) {
        is_showStaticAlert_Called = true
    }
    
    @objc func showDoubleActionAlert(_ title: String, message: String?, firstTitle:String, secondTitle:String?, onfirstClick:@escaping (() -> Void), onSecondClick:(() -> Void)?) {
        is_showDoubleActionAlert_Called = true
    }
    
    func showTableView() {
        is_showTableView_called = true
    }
    

    
}
