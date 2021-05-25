//
//  IntradayViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

class IntradayViewController: UIViewController {
    
    //MARK:- iboutlets and variables
    @IBOutlet var segmentControl:UISegmentedControl!
    @IBOutlet var tableView:UITableView!
    @IBOutlet var activityindicator: UIActivityIndicatorView!
//    @IBOutlet var collectionNilLabel:UILabel!
    var viewModel: IntradayViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: IntradayViewModel) -> IntradayViewController {
        
        let storyBoardRef = UIStoryboard.init(name: STRINGS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: STRINGS.VIEWCONTROLLERS.INTRADAY) as! IntradayViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.intradayProtocol = viewController
        viewController.title = (viewModel.search.symbol)! + " " + STRINGS.INTRADAY
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.BACK), style: UIBarButtonItem.Style.plain, target: self, action: #selector(IntradayViewController.back_buttonAction))
        navigationItem.leftBarButtonItem = leftBarButton
        
        viewModel.getCompanyData()
    }
    
    @objc func back_buttonAction() {
        
        viewModel.routeToDashboard()
    }
    
    @IBAction func segmentToggle(_ sender: UISegmentedControl) {
        
        viewModel.sortIDChange(index: sender.selectedSegmentIndex)
    }
}

extension IntradayViewController: IntradayViewModelProtocol {
    
    func showTableView() {
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    
    func showStaticAlert(_ title: String, message: String) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: STRINGS.OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
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
}

extension IntradayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntradayCell") as! IntradayCell
        cell.time_lbl.text = viewModel.getValue(index: indexPath.row, object: .date)
        cell.open_lbl.text = viewModel.getValue(index: indexPath.row, object: .open)
        cell.close_lbl.text = viewModel.getValue(index: indexPath.row, object: .close)
        cell.high_lbl.text = viewModel.getValue(index: indexPath.row, object: .high)
        cell.low_lbl.text = viewModel.getValue(index: indexPath.row, object: .low)
        return cell
    }
}

extension IntradayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
