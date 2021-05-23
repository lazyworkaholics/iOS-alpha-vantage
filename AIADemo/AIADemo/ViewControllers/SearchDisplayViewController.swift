//
//  SearchDisplayViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 23/05/2021.
//

import UIKit

class SearchDisplayViewController: UIViewController {

    @IBOutlet var tableView:UITableView!
    @IBOutlet var activityindicator: UIActivityIndicatorView!
    var viewModel: DashboardViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: DashboardViewModel) -> SearchDisplayViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.SEARCH) as! SearchDisplayViewController
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        viewModel.searchDisappeared()
    }
    
    // Mark: - ViewModel interactors
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
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: STRINGS.OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func showDoubleActionAlert(_ title: String, message: String?, firstTitle:String, secondTitle:String?, onfirstClick:@escaping (() -> Void), onSecondClick:(() -> Void)?) {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: firstTitle, style: .default, handler: { (nil) in
                onfirstClick()
            }))
            
            if secondTitle != nil && onSecondClick != nil {
                alert.addAction(UIAlertAction.init(title: secondTitle!, style: .default, handler: { (nil) in
                    onSecondClick!()
                }))
            }
            self.present(alert, animated: true, completion: nil)
        })
    }
}

//MARK:- TableView DataSource Protocol functions
extension SearchDisplayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.searchDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell
        cell.name_lbl.text = viewModel.searchDataSource[indexPath.row].name
        cell.symbol_lbl.text = viewModel.searchDataSource[indexPath.row].symbol
        return cell
    }
}

//MARK:- TableView DataSource Protocol functions
extension SearchDisplayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.searchSelected(index: indexPath.row)
    }
}
