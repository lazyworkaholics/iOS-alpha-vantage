//
//  ServiceManagerADJTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import XCTest
@testable import AIADemo

class ServiceManagerADJTests: XCTestCase {

    var serviceManagerToTest:ServiceManager?
    var mockNetworkManager:NetworkManagerMock?
    
    var mockCompany:Company?
    var testError:NSError?

    override func setUpWithError() throws {
        
        let text = "{\"Meta Data\":{\"1. Information\":\"Daily Time Series with Splits and Dividend Events\",\"2. Symbol\":\"TSLA\",\"3. Last Refreshed\":\"2021-05-21\",\"4. Output Size\":\"Compact\",\"5. Time Zone\": \"US/Eastern\"},\"Time Series (5min)\":{\"2021-05-20 20:00:00\":{\"1. open\":\"596.11\",\"2. high\":\"596.68\",\"3. low\":\"543.33\",\"4. close\":\"580.88\",\"5. volume\": \"14129\"},\"2021-05-20 19:00:00\":{\"1. open\":\"570.11\",\"2. high\":\"592.68\",\"3. low\":\"543.30\",\"4. close\":\"570.88\",\"5. volume\": \"15000\"}}}"
        let utf8str = text.data(using: .utf8)
        let decoder = JSONDecoder.init()
        mockCompany = try! decoder.decode(Company.self, from: utf8str!)
        
        testError = NSError.init(domain: "com.testingErrorDomain",
                                 code: 11010101843834,
                                 userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        serviceManagerToTest = ServiceManager.init()
        mockNetworkManager = NetworkManagerMock.init()
        mockNetworkManager?.data = text.data(using: .utf8)
        mockNetworkManager?.error = testError
    }

    override func tearDownWithError() throws {
        mockCompany = nil
        testError = nil
        mockNetworkManager = nil
        serviceManagerToTest = nil
    }

    func test_getDailyAdjusts_failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.getDailyAdjusts(["TSLA"], onCompletion: { dailyAdjust in

            XCTAssertNotNil(dailyAdjust.errors["TSLA"])
        })
    }
    
    func test_getCompanies_ValidData() {
        
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.getDailyAdjusts(["TSLA"], onCompletion: { [self] dailyAdjust in

            XCTAssertEqual(dailyAdjust.companies["TSLA"]?.metadata?.information, mockCompany?.metadata?.information, "failed to parse the given data into required model")
        })
    }
    
    func test_getCompanies_ValidData2() {
        
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.getDailyAdjusts(["TSLA", "IBM"], onCompletion: { [self] dailyAdjust in

            XCTAssertEqual(dailyAdjust.companies["TSLA"]?.metadata?.information, mockCompany?.metadata?.information, "failed to parse the given data into required model")
        })
    }
    
    func test_getCompanies_invalidData() {
        
        mockNetworkManager?.isSuccess = true
        mockNetworkManager?.data = "WrongData-invalide Case".data(using: .utf8)
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.getDailyAdjusts(["TSLA"], onCompletion: { [self] dailyAdjust in

            XCTAssertNotNil(dailyAdjust.errors["TSLA"])
        })
    }

}
