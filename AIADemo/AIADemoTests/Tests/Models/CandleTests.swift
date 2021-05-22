//
//  CandleTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import XCTest
@testable import AIADemo

class CandleTests: XCTestCase {

    func test_init_failure()  {
        
        let utf8str = "testText".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(Candle.self, from: utf8str!)
            XCTFail("init with coder should not create a candle object with this utf8str text")
        } catch {
            XCTAssert(true)
        }
    }
    
    func test_init_valideData()  {
        let text = "{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(Candle.self, from: utf8str!)
            XCTAssertTrue(true)
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_init_valideData2()  {
        let text = "{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"6. volume\": \"14129\",\"5. adjusted close\": \"580.88\", \"7. dividend amount\": \"0.0000\", \"8. split coefficient\": \"1.0\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let candle = try decoder.decode(Candle.self, from: utf8str!)
            
            XCTAssertEqual(candle.open, 596.11, "Object not created with correct mappings")
        } catch {
            print(error.localizedDescription)
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }
    
    func test_init_incorrect_data_types()  {
        let text = "{\"1. open\":596.11,\"2. high\":596.68,\"3. low\":543.33,\"4. close\":\"580.88\",\"6. volume\": \"14129\",\"5. adjusted close\": \"580.88\", \"7. dividend amount\": \"test\", \"8. split coefficient\": \"1.0\"}"
        let utf8str = text.data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let candle = try decoder.decode(Candle.self, from: utf8str!)
            
            XCTAssertEqual(candle.high, nil, "Object not created with correct mappings")
            XCTAssertEqual(candle.dividendAmount, nil, "Object not created with correct mappings")
        } catch {
            XCTFail("init with coder should not fail with an exception for this data")
        }
    }

}
