//
//  IntradayViewModelTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 25/05/2021.
//

import XCTest
@testable import AIADemo

class IntradayViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {

    }
    
    func testIntradayViewModelInit() {
        
        let viewmodel = IntradayViewModel.init(Search.init())
        XCTAssertNotNil(viewmodel.router)
        XCTAssertEqual(viewmodel.sortedCandles!.count, 0)
    }
    
    func test_getCompanyData_Service_ErrorCase() {
        var search = Search.init()
        search.name = "test_name"
        search.symbol = "test_symbol"
        let viewmodel = IntradayViewModel.init(search)
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        let mock_error =  NSError.init(domain: "com.testingErrorDomain", code: 11010101843834, userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        var mock_service = ServiceManagerMock.init()
        mock_service.mock_error = mock_error
        mock_service.isServiceCallSuccess = false
        viewmodel.serviceManager = mock_service
        
        let mockIntradayProtocol = IntradayViewModelMock.init()
        viewmodel.intradayProtocol = mockIntradayProtocol
        
        
        // when getCompanyData is called and service manager returns error
        // intradayProtocol's - showLoadingIndicator, showStaticAlert and hideloadingIndicator should be invoked
        viewmodel.getCompanyData()
        
        XCTAssertTrue(mockIntradayProtocol.is_showLoadingIndicator_Called, "showLoadingIndicator of IntradayViewController should be invoked")
        XCTAssertTrue(mockIntradayProtocol.is_hideLoadingIndicator_Called, "hideLoadingIndicator of IntradayViewController should be invoked")
        XCTAssertTrue(mockIntradayProtocol.is_showStaticAlert_Called, "showStaticAlert of IntradayViewController should be invoked")
    }
    
    func test_getCompanyData_Service_Result_ValidCase() {
        var search = Search.init()
        search.name = "test_name"
        search.symbol = "test_symbol"
        let viewmodel = IntradayViewModel.init(search)
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        var mock_service = ServiceManagerMock.init()
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            mock_service.mock_company = company
            mock_service.isServiceCallSuccess = true
            viewmodel.serviceManager = mock_service
            
            let mockIntradayProtocol = IntradayViewModelMock.init()
            viewmodel.intradayProtocol = mockIntradayProtocol
            
            
            // when getData is called and service manager returns success with valid Data
            // intradayProtocol's - showLoadingIndicator, showStaticAlert and hideloadingIndicator should be invoked
            viewmodel.getCompanyData()
            
            XCTAssertEqual(viewmodel.dataSource?.metadata?.information, company.metadata?.information, "the data should be parsed correct without errors")
            XCTAssertTrue(mockIntradayProtocol.is_showTableView_called, "showTableView of IntradayViewController should be invoked")
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_getCompanyData_Service_Result_with_ErrorMessage() {
        var search = Search.init()
        search.name = "test_name"
        search.symbol = "test_symbol"
        let viewmodel = IntradayViewModel.init(search)
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        var mock_service = ServiceManagerMock.init()
        let text = "{\"Error Message\":\"Test Error Message\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            mock_service.mock_company = company
            mock_service.isServiceCallSuccess = true
            viewmodel.serviceManager = mock_service
            
            let mockIntradayProtocol = IntradayViewModelMock.init()
            viewmodel.intradayProtocol = mockIntradayProtocol
            
            
            // when getData is called and service manager returns success with valid Data
            // intradayProtocol's - showLoadingIndicator, showStaticAlert and hideloadingIndicator should be invoked
            viewmodel.getCompanyData()
            
            XCTAssertTrue(mockIntradayProtocol.is_showStaticAlert_Called, "showStaticAlert of IntradayViewController should be invoked")
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_routeToDashboard() {
        let viewmodel = IntradayViewModel.init(Search.init())
        
        let routerMock = RouterMock.init()
        viewmodel.router = routerMock
        
        viewmodel.routeToDashboard()
        
        XCTAssertTrue(routerMock.is_backToDashboard_called, "backToDashboard of Router should be invoked")
    }
    
    func test_getRowCount_getValue() {
        let viewmodel = IntradayViewModel.init(Search.init())
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            viewmodel.dataSource = company
            viewmodel.sortIDChange(index: 0)
            
            XCTAssertEqual(viewmodel.getRowCount(), 2)
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .date), "20:00")
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .open), "596.11")
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .high), "596.68")
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .low), "543.33")
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .close), "580.88")
        
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_sortIDChange() {
        let viewmodel = IntradayViewModel.init(Search.init())
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            viewmodel.dataSource = company
            viewmodel.sortIDChange(index: 1)
            
            XCTAssertEqual(viewmodel.getRowCount(), 2)
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .date), "20:00")
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .open), "596.11")
            
            viewmodel.sortIDChange(index: 2)
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .high), "596.68")
            
            viewmodel.sortIDChange(index: 3)
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .low), "543.33")
            
            viewmodel.sortIDChange(index: 4)
            XCTAssertEqual(viewmodel.getValue(index: 0, object: .close), "580.88")
        
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
}


