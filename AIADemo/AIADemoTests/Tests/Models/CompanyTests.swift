//
//  CompanyTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import XCTest
@testable import AIADemo

class CompanyTests: XCTestCase {


    func test_init_failure()  {
        
        let utf8str = "testText".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(Company.self, from: utf8str!)
            XCTFail("init with coder should not create a candle object with this utf8str text")
        } catch {
            XCTAssert(true)
        }
    }
    
    func test_init_valideData()  {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(Company.self, from: utf8str!)
            XCTAssertTrue(true)
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_init_errormessage()  {
        let text = "{\"Error Message\":\"Test Error message\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            XCTAssertEqual(company.errorMessage, "Test Error message", "init with coder should not create a company with error message" )
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_init_errormessage_failure()  {
        let text = "{\"Error Message\":404}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            XCTAssertEqual(company.errorMessage, nil)
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_sortData_open()  {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            let candles = company.getCandles(.open)
            XCTAssertEqual(candles[1].open, 570.11, "failed to sort by opening" )
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_sortData_close()  {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            let candles = company.getCandles(.close)
            XCTAssertEqual(candles[0].close, 580.88, "failed to sort by close" )
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_sortData_high()  {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            let candles = company.getCandles(.high)
            XCTAssertEqual(candles[1].high, 592.68, "failed to sort by high" )
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_sortData_low()  {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            let candles = company.getCandles(.low)
            XCTAssertEqual(candles[0].low, 543.33, "failed to sort by low" )
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_sortData_date()  {
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let company = try decoder.decode(Company.self, from: utf8str!)
            
            let candles = company.getCandles(.date)
            XCTAssertEqual(candles[1].open, 570.11, "failed to sort by opening" )
            
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
}
