//
//  DailyAdjViewController.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import XCTest
@testable import AIADemo

class DailyAdjViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ViewDidLoad() {
        
        var search = Search.init()
        search.symbol = "Test Symbol"
        let dailyAdjViewModelMock = DailyAdjViewModelMock.init([search])
        let viewController = DailyAdjViewController.initWithViewModel(dailyAdjViewModelMock)
        viewController.loadView()
        viewController.viewDidLoad()
        
        XCTAssertTrue(dailyAdjViewModelMock.is_getData_called)
    }
    
    func test_userInteractions() {
        
        var search = Search.init()
        search.symbol = "Test Symbol"
        let dailyAdjViewModelMock = DailyAdjViewModelMock.init([search])
        let viewController = DailyAdjViewController.initWithViewModel(dailyAdjViewModelMock)
        viewController.loadView()
        
        viewController.back_buttonAction()
        XCTAssertTrue(dailyAdjViewModelMock.is_routeToDashboard_called)
        
        viewController.showLoadingIndicator()
        viewController.segmentToggle(viewController.segmentControl)
        XCTAssertTrue(dailyAdjViewModelMock.is_segmentValueChange_called)
    }
    
    func test_tableVieWFunctions() {
        
        var search = Search.init()
        search.symbol = "Test Symbol"
        let dailyAdjViewModelMock = DailyAdjViewModelMock.init([search])
        let viewController = DailyAdjViewController.initWithViewModel(dailyAdjViewModelMock)
        viewController.loadView()
        
        let test_rows = 18
        dailyAdjViewModelMock.mock_rows = test_rows
        XCTAssertEqual(viewController.tableView(viewController.tableView, numberOfRowsInSection: 0), test_rows)
        
        let test_srting = "test String"
        dailyAdjViewModelMock.mock_String = test_srting
        viewController.hideLoadingIndicator()
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)) as! DailyAdjCell
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertEqual(cell.c1_lbl.text, test_srting)
        XCTAssertEqual(cell.c2_lbl.text, test_srting)
        XCTAssertEqual(cell.c3_lbl.text, test_srting)
    }
    
    func testReloadData()  {
        var search = Search.init()
        search.symbol = "Test Symbol"
        let dailyAdjViewModelMock = DailyAdjViewModelMock.init([search])
        let viewController = DailyAdjViewController.initWithViewModel(dailyAdjViewModelMock)
        viewController.loadView()
        
        let test_rows = 18
        dailyAdjViewModelMock.mock_rows = test_rows
        
        let test_srting = "test String"
        dailyAdjViewModelMock.mock_String = test_srting
        viewController.hideLoadingIndicator()
        viewController.reloadData()
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0)) as! DailyAdjCell
        viewController.tableView(viewController.tableView, didSelectRowAt: IndexPath.init(row: 0, section: 0))
        XCTAssertEqual(cell.c1_lbl.text, test_srting)
        XCTAssertEqual(cell.c2_lbl.text, test_srting)
        XCTAssertEqual(cell.c3_lbl.text, test_srting)
    }
    
    func test_setSegmentHeaders() {
        var search = Search.init()
        search.symbol = "Test Symbol"
        let dailyAdjViewModelMock = DailyAdjViewModelMock.init([search])
        let viewController = DailyAdjViewController.initWithViewModel(dailyAdjViewModelMock)
        viewController.loadView()
        viewController.setSegmentHeaders(titles: ["Date", "test2", "test3", "test4"])
        XCTAssertEqual(viewController.segmentControl.titleForSegment(at: 0), "Date")
    }

}
