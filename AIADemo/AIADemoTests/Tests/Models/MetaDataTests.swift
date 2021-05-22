//
//  MetaData.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import XCTest
@testable import AIADemo

class MetaDataTests: XCTestCase {

    func test_init_failure()  {
        
        let utf8str = "testText".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(MetaData.self, from: utf8str!)
            XCTFail("init with coder should not create a candle object with this utf8str text")
        } catch {
            XCTAssert(true)
        }
    }
    
    func test_init_valideData()  {
        let text = "{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(MetaData.self, from: utf8str!)
            XCTAssertTrue(true)
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_init_valideData2()  {
        let text = "{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Interval\":\"5min\",\"5. Output Size\":\"Compact\",\"6. Time Zone\": \"US/Eastern\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let metadata = try decoder.decode(MetaData.self, from: utf8str!)
            
            XCTAssertEqual(metadata.information, "Daily Time Series with Splits and Dividend Events", "Object not created with correct mappings")
        } catch {
            print(error.localizedDescription)
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_init_incorrect_data_types()  {
        let text = "{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"test\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": 111}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let metadata = try decoder.decode(MetaData.self, from: utf8str!)

            XCTAssertEqual(metadata.refreshTime, nil, "Object not created with correct mappings")
            XCTAssertEqual(metadata.timezone, nil, "Object not created with correct mappings")
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }

}
