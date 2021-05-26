//
//  DailyAdjViewModelTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import XCTest
@testable import AIADemo

class DailyAdjViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIntradayViewModelInit() {
        
        let viewmodel = DailyAdjViewModel.init([Search.init()])
        XCTAssertNotNil(viewmodel.router)
        XCTAssertNotNil(viewmodel.serviceManager)
    }
    
    func test_getData_Service_ErrorCase() {
        var search = Search.init()
        search.name = "test_name"
        search.symbol = "test_symbol"
        let viewmodel = DailyAdjViewModel.init([search])
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mock_error =  NSError.init(domain: "com.testingErrorDomain", code: 11010101843834, userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        var mock_service = ServiceManagerMock.init()
        mock_service.mock_error = mock_error
        mock_service.isServiceCallSuccess = false
        viewmodel.serviceManager = mock_service
        
        let mockDailyAdjProtocol = DailyAdjViewModelMock.init()
        viewmodel.dailyAdjProtocol = mockDailyAdjProtocol
        
        
        // when getData is called and service manager returns error
        // dailyAdjProtocol's - showLoadingIndicator, showStaticAlert and hideloadingIndicator should be invoked
        viewmodel.getData()
        
        XCTAssertTrue(mockDailyAdjProtocol.is_showLoadingIndicator_Called, "showLoadingIndicator of DailyAdjViewController should be invoked")
        XCTAssertTrue(mockDailyAdjProtocol.is_hideLoadingIndicator_Called, "hideLoadingIndicator of DailyAdjViewController should be invoked")
        XCTAssertTrue(mockDailyAdjProtocol.is_showStaticAlert_Called, "showStaticAlert of DailyAdjViewController should be invoked")
    }
    
    func test_getData_Service_Result_ValidCase() {
        var search = Search.init()
        search.name = "test_name"
        search.symbol = "test_symbol"
        let viewmodel = DailyAdjViewModel.init([search])
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        var mock_service = ServiceManagerMock.init()
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
//            mock_service.mock_company = company
            mock_service.mock_dailyAdj = DailyAdjust.init(symbols: ["TSLA"], companies: ["TSLA" : company], errors: [:], timeZone: "", uniqueDates: [], parsedData: [:])
            mock_service.isServiceCallSuccess = true
            viewmodel.serviceManager = mock_service
            
            let mockDailyAdjProtocol = DailyAdjViewModelMock.init()
            viewmodel.dailyAdjProtocol = mockDailyAdjProtocol
            
            
            // when getData is called and service manager returns success with valid Data
            // dailyAdjProtocol's - showLoadingIndicato and hideloadingIndicator should be invoked
            // dailyAdjProtocol's - should match the above assigned value
            viewmodel.getData()
            
            XCTAssertEqual(viewmodel.dataSource?.symbols, ["TSLA"], "the data should be parsed correct without errors")
            XCTAssertTrue(mockDailyAdjProtocol.is_showLoadingIndicator_Called, "showLoadingIndicator of DailyAdjViewController should be invoked")
            XCTAssertTrue(mockDailyAdjProtocol.is_hideLoadingIndicator_Called, "hideLoadingIndicator of DailyAdjViewController should be invoked")
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_getData_Service_Result_with_ErrorMessage() {
        var search = Search.init()
        search.name = "test_name"
        search.symbol = "test_symbol"
        let viewmodel = DailyAdjViewModel.init([search])
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        var mock_service = ServiceManagerMock.init()
        let text = "{\"Error Message\":\"Test Error Message\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            mock_service.mock_dailyAdj = DailyAdjust.init(symbols: ["TSKL"], companies: ["TSKA" : company], errors: ["TSLA":NSError.init()], timeZone: nil, uniqueDates: [], parsedData: [:])
            mock_service.isServiceCallSuccess = true
            viewmodel.serviceManager = mock_service
            
            let mockDailyAdjiProtocol = DailyAdjViewModelMock.init()
            viewmodel.dailyAdjProtocol = mockDailyAdjiProtocol
            
            
            // when getData is called and service manager returns success with valid Data
            // intradayProtocol's - showLoadingIndicator, showStaticAlert and hideloadingIndicator should be invoked
            viewmodel.getData()
            
            XCTAssertTrue(mockDailyAdjiProtocol.is_showStaticAlert_Called, "showStaticAlert of IntradayViewController should be invoked")
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_SegmentChange() {
        let viewmodel = DailyAdjViewModel.init([Search.init()])
        let mockDailyAdjProtocol = DailyAdjViewModelMock.init()
        viewmodel.dailyAdjProtocol = mockDailyAdjProtocol
        
        viewmodel.segmentValueChange(index: 0)
        XCTAssertEqual(viewmodel.compareBy, CompareBy.open)
        XCTAssertTrue(mockDailyAdjProtocol.is_showTableView_called, "TableViewShould be reload")
        
        viewmodel.segmentValueChange(index: 1)
        XCTAssertEqual(viewmodel.compareBy, CompareBy.high)
        
        viewmodel.segmentValueChange(index: 2)
        XCTAssertEqual(viewmodel.compareBy, CompareBy.low)
        
        viewmodel.segmentValueChange(index: 3)
        XCTAssertEqual(viewmodel.compareBy, CompareBy.close)
    }
    
    func test_routeToDashboard() {
        let viewmodel = DailyAdjViewModel.init([Search.init()])
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        viewmodel.routeToDashboard()
        
        XCTAssertTrue(routerMock.is_backToDashboard_called, "backToDashboard of Router should be invoked")
    }
    
    func test_getRowCount() {
        
        let viewmodel = DailyAdjViewModel.init([Search.init()])
        viewmodel.dataSource = DailyAdjust.init(symbols: [], companies: [:], errors: [:], timeZone: nil, uniqueDates: ["date1","date2","date3"], parsedData: [:])
        
        XCTAssertEqual(viewmodel.getRowCount(), 3)
    }
    
    func test_getDataForRow() {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-19\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            let viewmodel = DailyAdjViewModel.init([Search.init()])
            viewmodel.dataSource = DailyAdjust.init(symbols: ["TSLA","IBM","SQ"], companies: ["TSLA":company,"IBM":company,"SQ":company], errors: [:], timeZone: "US/Eastern", uniqueDates: ["2021-05-20", "2021-05-19"], parsedData: [:])
            viewmodel.dataSource?.parseData()
            
            XCTAssertEqual(viewmodel.getRowCount(), 2)
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "570.11", "570.11", "570.11"])
            
            viewmodel.compareBy = .close
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "570.88", "570.88", "570.88"])
            
            viewmodel.compareBy = .high
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "592.68", "592.68", "592.68"])
            
            viewmodel.compareBy = .low
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "543.3", "543.3", "543.3"])
            
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_getDataForRow2() {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-19\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            let viewmodel = DailyAdjViewModel.init([Search.init()])
            viewmodel.dataSource = DailyAdjust.init(symbols: ["TSLA"], companies: ["TSLA":company], errors: [:], timeZone: "US/Eastern", uniqueDates: ["2021-05-20", "2021-05-19"], parsedData: [:])
            viewmodel.dataSource?.parseData()
            
            XCTAssertEqual(viewmodel.getRowCount(), 2)
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "570.11", "-", "-"])
            
            viewmodel.compareBy = .close
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "570.88", "-", "-"])
            
            viewmodel.compareBy = .high
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "592.68", "-", "-"])
            
            viewmodel.compareBy = .low
            XCTAssertEqual(viewmodel.getData(for: 0), ["2021-05-20", "543.3", "-", "-"])
            
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
}
