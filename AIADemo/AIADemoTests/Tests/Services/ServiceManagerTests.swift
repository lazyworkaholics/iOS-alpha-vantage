//
//  ServiceManagerTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import XCTest
@testable import AIADemo

class ServiceManagerTests: XCTestCase {
    
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
    
    func test_getCompanies_failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.getData("TSLA", isIntraday: true,
                                      onSuccess: { (company) in
            
                                        XCTFail("Success block should not be called if there is an internal network error.")
                                      }, onFailure: { (error) in
            
                                        XCTAssertEqual(error, self.testError!, "getData function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func test_getCompanies_ValidData() {
        
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.getData("TSLA", isIntraday: false,
                                      onSuccess: { [self] (company) in
            
                                        XCTAssertEqual(company.metadata?.information, mockCompany?.metadata?.information, "failed to parse the given data into required model")
                                        XCTAssertEqual(company.candles.count, mockCompany?.candles.count, "failed to parse the given data into required model")
                                      }, onFailure: { (error) in
            
                                        XCTFail("Failure block should not be called when network manager returns a valid data object.")
        })
    }
    
    func test_getCompanies_invalidData() {
        
        mockNetworkManager?.isSuccess = true
        mockNetworkManager?.data = "WrongData-invalide Case".data(using: .utf8)
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.getData("TSLA", isIntraday: false,
                                      onSuccess: { (company) in
            
                                        XCTFail("Success block should not be called the data is  not in valid format")
                                      }, onFailure: { (error) in
            
                                        XCTAssertTrue(true)
        })
    }
}
