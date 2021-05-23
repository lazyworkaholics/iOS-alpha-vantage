//
//  ViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import UIKit

class DashboardViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    //MARK:- iboutlets and variables
    @IBOutlet var searchBar:UITextField!
    @IBOutlet var segmentControl:UISegmentedControl!
    
    @IBOutlet var collectionView:UICollectionView!
    @IBOutlet var collectionNilLabel:UILabel!
    
    var viewModel: DashboardViewModel!
    var popover: UIPopoverPresentationController!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: DashboardViewModel) -> DashboardViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.DASHBOARD) as! DashboardViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.dashboardProtocol = viewController
        viewController.title = STRINGS.DASHBOARD
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem.init(image: UIImage.init(named: "settings"), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashboardViewController.settings_buttonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    //MARK:- Custom Button Actions
    @objc func settings_buttonAction() {
        
    }
    
    @IBAction func searchTextChange(_ sender: Any) {
        
        viewModel.searchforCompanies(keyword: searchBar.text!)
    }
}

extension DashboardViewController: DashboardViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: STRINGS.OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func displaySearch(controller:SearchDisplayViewController) {
        
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.delegate = self
        controller.popoverPresentationController?.permittedArrowDirections = .any
        controller.popoverPresentationController?.sourceView = searchBar
        controller.popoverPresentationController?.sourceRect = CGRect.init(x: searchBar.frame.origin.x, y: searchBar.frame.origin.y-90, width: searchBar.frame.width, height: searchBar.frame.height)
        self.present(controller, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func hideSearch(controller:SearchDisplayViewController) {
        
        controller.dismiss(animated: false, completion: nil)
    }
    
    func dismissSearchKeyboard() {
        
        self.searchBar.resignFirstResponder()
    }
    
    func clearSearchText() {
        
        self.searchBar.text = ""
    }
}

//MARK: - UITextFieldDelegate functions
extension DashboardViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        viewModel.searchforCompanies(keyword: searchBar.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}

