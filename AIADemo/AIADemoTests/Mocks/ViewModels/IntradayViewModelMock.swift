//
//  IntradayViewModelMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import UIKit
@testable import AIADemo

class IntradayViewModelMock: IntradayViewModel {
    
    var is_routeToDashboard_Called = false
    var is_sortIDChange_Called = false
    var getValueText:String?
    
    override func routeToDashboard() {
        is_routeToDashboard_Called = true
    }
    
    override func sortIDChange(index: Int) {
        is_sortIDChange_Called = true
    }
    
    override func getValue(index: Int, object: SortBy) -> String {
        return getValueText!
    }
}
