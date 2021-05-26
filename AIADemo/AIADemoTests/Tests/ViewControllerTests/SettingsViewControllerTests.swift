//
//  SettingsViewControllerTests.swift
//  AIADemoTests
//
//  Created by Harsha VARDHAN on 26/05/2021.
//

import XCTest
@testable import AIADemo

class SettingsViewControllerTests: XCTestCase {

    func test_initialization() {
        let settingViewModelMock = SettingsViewModelMock.init()
        settingViewModelMock.getIntervalSegmentIndex_mock = 1
        settingViewModelMock.getOutputSizeSegmentIndex_mock = 0
        settingViewModelMock.getapikeyText_mock = "test"
        let viewController = SettingsViewController.initWithViewModel(settingViewModelMock)
        viewController.loadView()
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.title)
    }
    
    func test_userInteractions()  {
        let settingViewModelMock = SettingsViewModelMock.init()
        
        let viewController = SettingsViewController.initWithViewModel(settingViewModelMock)
        viewController.loadView()
        
        viewController.back_buttonAction()
        XCTAssertTrue(settingViewModelMock.is_routeToDashboard_called)
        
        viewController.setAPIKeyAction(UIButton.init())
        viewController.outputSegmentToggle(viewController.outputSizeSegment)
        XCTAssertTrue(settingViewModelMock.is_setOutputSize_callled)
        
        viewController.intervalSegmentToggle(viewController.intervalSegment)
        XCTAssertTrue(settingViewModelMock.is_setInterval_called)
    }
}
