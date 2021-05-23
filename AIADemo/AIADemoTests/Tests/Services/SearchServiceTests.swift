//
//  SearchServiceTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import XCTest
@testable import AIADemo

class SearchServiceTests: XCTestCase {

    var serviceManagerToTest:ServiceManager?
    var mockNetworkManager:NetworkManagerMock?
    
    var mockSearches:[Search]?
    var testError:NSError?

    override func setUpWithError() throws {
        
        let text = "{\"bestMatches\":[{\"1. symbol\":\"TSLA\",\"2. name\":\"Tesla Inc\"}]}"
        let utf8str = text.data(using: .utf8)
        let decoder = JSONDecoder.init()
        
        let results = try! decoder.decode([String:[Search]].self, from: utf8str!)
        mockSearches = results[STRINGS.BEST_MATCHES]
        
        testError = NSError.init(domain: "com.testingErrorDomain",
                                 code: 11010101843834,
                                 userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        serviceManagerToTest = ServiceManager.init()
        mockNetworkManager = NetworkManagerMock.init()
        mockNetworkManager?.data = text.data(using: .utf8)
        mockNetworkManager?.error = testError
    }

    override func tearDownWithError() throws {
        mockSearches = nil
        testError = nil
        mockNetworkManager = nil
        serviceManagerToTest = nil
    }
    
    func test_search_failed() {
        mockNetworkManager?.isSuccess = false
        
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.search("test", onSuccess: { searches in
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: { error in
            XCTAssertEqual(error, self.testError!, "getData function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    func test_search_ValidData() {
        
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.search("test",
                                      onSuccess: { [self] (searches) in
            
                                        XCTAssertEqual(searches[0].symbol, mockSearches![0].symbol, "failed to parse the given data into required model")
                                        XCTAssertEqual(searches[0].name, mockSearches![0].name, "failed to parse the given data into required model")
                                      }, onFailure: { (error) in
            
                                        XCTFail("Failure block should not be called when network manager returns a valid data object.")
        })
    }
    
    func test_search_invalidData() {
        
        mockNetworkManager?.isSuccess = true
        mockNetworkManager?.data = "WrongData-invalide Case".data(using: .utf8)
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.search("test",
                                      onSuccess: { (searches) in
            
                                        XCTFail("Success block should not be called the data is  not in valid format")
                                      }, onFailure: { (error) in
            
                                        XCTAssertTrue(true)
        })
    }
    
    func test_search_nilresults() {
        
        let text = "{\"wrongString\":[{\"1. symbol\":\"TSLA\",\"2. name\":\"Tesla Inc\"}]}"
        let utf8str = text.data(using: .utf8)
        let decoder = JSONDecoder.init()
        
        let results = try! decoder.decode([String:[Search]].self, from: utf8str!)
        mockSearches = results[STRINGS.BEST_MATCHES]
        
        testError = NSError.init(domain: "com.testingErrorDomain",
                                 code: 11010101843834,
                                 userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        serviceManagerToTest = ServiceManager.init()
        mockNetworkManager = NetworkManagerMock.init()
        mockNetworkManager?.data = text.data(using: .utf8)
        mockNetworkManager?.error = testError
        
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        
        serviceManagerToTest?.search("test",
                                      onSuccess: { (searches) in
            
                                        XCTAssertEqual(searches.count, 0, "failed to parse nil count")
                                      }, onFailure: { (error) in
            
                                        XCTFail("Failure block should not be called when network manager returns a valid data object.")
        })
    }

}
