//
//  DailyAdjViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

class DailyAdjViewController: UIViewController {

    //MARK:- iboutlets and variables
    @IBOutlet var tableView:UITableView!
    
    var viewModel: DailyAdjViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: DailyAdjViewModel) -> DailyAdjViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.DAILYADJ) as! DailyAdjViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.dailyAdjProtocol = viewController
        viewController.title = STRINGS.DAILYADJ
        
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

extension DailyAdjViewController: DailyAdjViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
}
