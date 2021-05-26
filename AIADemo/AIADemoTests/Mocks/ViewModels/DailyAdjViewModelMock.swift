//
//  DailyAdjViewModelMock.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import UIKit
@testable import AIADemo


class DailyAdjViewModelMock: DailyAdjViewModel {

    var is_getData_called = false
    var is_routeToDashboard_called = false
    var is_segmentValueChange_called = false
    var is_getRowCount_called = false
    var is_getDataForIndex_called = false
    var mock_rows:Int?
    var mock_String:String?
    
    override func getData() {
        is_getData_called = true
    }
    
    override func routeToDashboard() {
        is_routeToDashboard_called = true
    }
    
    override func segmentValueChange(index: Int) {
        is_segmentValueChange_called = true
    }
    
    override func getRowCount() -> Int {
        is_getRowCount_called = true
        return mock_rows!
    }
    
    override func getData(for index: Int) -> [String] {
        is_getDataForIndex_called = true
        return [mock_String!,mock_String!,mock_String!,mock_String!]
    }
}
