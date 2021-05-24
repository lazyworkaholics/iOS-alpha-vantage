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
    
    @IBOutlet var intervalSegment: UISegmentedControl!
    @IBOutlet var outputSizeSegment: UISegmentedControl!
    @IBOutlet var apikeyTextField: UITextField!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: SettingsViewModel) -> SettingsViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.SETTINGS) as! SettingsViewController
        
        viewController.viewModel = viewModel
        viewController.title = STRINGS.SETTINGS2
        
        return viewController
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.DOWN), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back_buttonAction))
        navigationItem.leftBarButtonItem = leftBarButton
        
        intervalSegment.selectedSegmentIndex = viewModel.getIntervalSegmentIndex()
        outputSizeSegment.selectedSegmentIndex = viewModel.getOutputSizeSegmentIndex()
        apikeyTextField.text = viewModel.getapikeyText()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func back_buttonAction() {
        
        viewModel.navigateToDashboard()
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func outputSegmentToggle(_ sender: UISegmentedControl) {
        
        hideKeyboard()
        viewModel.setOutputSize(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func intervalSegmentToggle(_ sender: UISegmentedControl) {
        
        hideKeyboard()
        viewModel.setOutputSize(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func setAPIKeyAction(_ sender: UIButton) {
        
        hideKeyboard()
        if apikeyTextField.text != "" {
            viewModel.setAPIKey(key: apikeyTextField.text!)
        }
    }
    
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
