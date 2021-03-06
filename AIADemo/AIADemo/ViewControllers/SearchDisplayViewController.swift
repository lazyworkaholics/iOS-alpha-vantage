//
//  SearchDisplayViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import UIKit

class SearchDisplayViewController: UIViewController {

    //MARK:- iboutlets and variables
    var viewModel: DashboardViewModel!
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var activityindicator: UIActivityIndicatorView!
    
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: DashboardViewModel) -> SearchDisplayViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.SEARCH) as! SearchDisplayViewController
        viewController.viewModel = viewModel
        viewModel.searchProtocol = viewController
        return viewController
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        viewModel.searchDisappeared()
    }
}

// MARK: - protocol implementations
extension SearchDisplayViewController: ViewModelProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityindicator.isHidden = false
            self.activityindicator.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.activityindicator.stopAnimating()
        }
    }
    
    func showStaticAlert(_ title: String, message: String) {
        RedundantFunctions.init().showStaticAlert(title, message: message, onViewController: self)
    }
    
    func showDoubleActionAlert(_ title: String, message: String?, firstTitle:String, secondTitle:String?, onfirstClick:@escaping (() -> Void), onSecondClick:(() -> Void)?) {
        
        RedundantFunctions.init().showDoubleActionAlert(title, message: message, firstTitle: firstTitle, secondTitle: secondTitle, onfirstClick: onfirstClick, onSecondClick: onSecondClick, onViewController: self)
    }
}

//MARK: - tableView delegate and datasource functions
extension SearchDisplayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getSearchCompaniesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: STRINGS.CELLS.SEARCH) as! SearchCell
        cell.name_lbl.text = viewModel.getSearchCompanyName(for: indexPath.row)
        cell.symbol_lbl.text = viewModel.getSearchCompanySymbol(for: indexPath.row)
        return cell
    }
}

extension SearchDisplayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.searchSelected(index: indexPath.row)
    }
}
