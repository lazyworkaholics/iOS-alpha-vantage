//
//  NetworkManagerTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import XCTest

@testable import AIADemo

class NetworkManagerTests: XCTestCase {

    var networkManagerToTest: NetworkManager?
    
    override func setUpWithError() throws {
        
        networkManagerToTest = NetworkManager.init()
    }

    override func tearDownWithError() throws {
        let defaultConfiguration = URLSessionConfiguration.default
        networkManagerToTest?.urlSession = URLSession.init(configuration: defaultConfiguration)
    }

    func testInternalServerError() {
        let mockSession = URLSessionMock.init()
        mockSession.data = nil
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 500,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        
        networkManagerToTest?.httpRequest("test",
                                          params: [:],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: nil,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is an internal server error.")
        },
                                          onFailure: {
                                            (error) in
                                            XCTAssertEqual(500, error.code, "Error object should return error code 500")
        })
    }
    
    func testNoInternetConnection() {
        
        networkManagerToTest?.isConnectedToNetwork = false
        
        networkManagerToTest?.httpRequest("test",
                                          params: nil,
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: nil,
                                          onSuccess: { (
                                            responseData) in
                                            XCTFail("Success block should not be called if there is no network connection.")
        },
                                          onFailure: {
                                            (error) in
                                            XCTAssertEqual(ERROR.CODE.NO_INTERNET, error.code, "Error object should return error code 1009")
        })
    }
    
    func testSuccessCase() {
        let mockSession = URLSessionMock.init()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")
        let mockResponseData = Data.init(base64Encoded:"VGhpcyBpcyBub3QgYSBKU09O")
        mockSession.data = mockResponseData
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        

        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881", "bih":"1066", "bia":"1068"],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTAssertEqual(responseData, mockResponseData, "response data is mismatched")
        },
                                          onFailure: { (error) in
                                            XCTFail("Error should not be received for this success scenario")
                                            
        })
    }
    
    func testNilResponseDataReceiverCase() {
        let mockSession = URLSessionMock.init()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")

        mockSession.data = nil
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        

        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881", "bih":"1066"],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is no data in response.")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(ERROR.CODE.PARSING_ERROR, error.code, "Error object should return error code 1010")
        })
    }
    
    func testNon200StatusReceiverCase() {
        let mockSession = URLSessionMock.init()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")

        mockSession.data = nil
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 400,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        

        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881"],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if the status code is non 200s")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(400, error.code, "Error object should return error code 400 as specified above")
        })
    }
    
    func testNilResponseReceiverCase() {
        let mockSession = URLSessionMock.init()
        let mockRequestData = Data("test_data".utf8)

        mockSession.data = nil
        mockSession.response = nil
        mockSession.error = nil
        

        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881", "bih":"1066"],
                                          method: HTTPRequestType.GET,
                                          headers: [NETWORK.HTTP_HEADER_CONTENT_TYPE_KEY:NETWORK.HTTP_HEADER_CONTENT_TYPE_VALUE_APP_JSON],
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is no response.")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(ERROR.CODE.PARSING_ERROR, error.code, "Error object should return error code 1010")
        })
    }
    
    func testNilErrorReceiverCase() {
        let mockSession = URLSessionMock.init()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")

        mockSession.data = nil
        mockSession.response = nil
        let error1 = NSError.init(domain: "custom error", code: 1, userInfo: nil)
        mockSession.error = error1
        

        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        
        networkManagerToTest?.httpRequest("test/test2",
                                          params: ["biw":"1881", "bih":"1066"],
                                          method: HTTPRequestType.GET,
                                          headers: [NETWORK.HTTP_HEADER_CONTENT_TYPE_KEY:NETWORK.HTTP_HEADER_CONTENT_TYPE_VALUE_APP_JSON],
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is error in response.")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(error1, error, "Error object should match as specified above")
        })
    }

}
