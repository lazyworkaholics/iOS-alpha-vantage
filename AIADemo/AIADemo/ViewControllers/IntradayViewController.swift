//
//  IntradayViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

class IntradayViewController: UIViewController {
    
    //MARK:- iboutlets and variables
    @IBOutlet var tableView:UITableView!
    
    var viewModel: IntradayViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: IntradayViewModel) -> IntradayViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.INTRADAY) as! IntradayViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.intradayProtocol = viewController
        viewController.title = STRINGS.INTRADAY
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.BACK), style: UIBarButtonItem.Style.plain, target: self, action: #selector(IntradayViewController.back_buttonAction))
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func back_buttonAction() {
        
        viewModel.navigateToDashboard()
    }
}

extension IntradayViewController: IntradayViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
}
