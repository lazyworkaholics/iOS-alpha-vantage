//
//  SettingsViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

class SettingsViewController: UIViewController {

    //MARK:- iboutlets and variables
    var viewModel: SettingsViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: SettingsViewModel) -> SettingsViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.SETTINGS) as! SettingsViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.settingsProtocol = viewController
        viewController.title = STRINGS.DAILYADJ
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SettingsViewController: SettingsViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
}
