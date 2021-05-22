//
//  ViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import UIKit

class DashboardViewController: UIViewController {

    //MARK:- iboutlets and variables
    @IBOutlet var collectionView:UICollectionView!
    
    var viewModel: DashboardViewModel!
    
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
    }
}

extension DashboardViewController: DashboardViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
}

