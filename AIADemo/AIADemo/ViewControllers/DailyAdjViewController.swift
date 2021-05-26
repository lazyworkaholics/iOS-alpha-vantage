//
//  DailyAdjViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

class DailyAdjViewController: UIViewController {

    //MARK:- iboutlets and variables
    var viewModel: DailyAdjViewModel!
    
    @IBOutlet var segmentControl:UISegmentedControl!
    @IBOutlet var segmentControl2:UISegmentedControl!
    @IBOutlet var tableView:UITableView!
    @IBOutlet var activityindicator: UIActivityIndicatorView!
    
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

        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.BACK), style: UIBarButtonItem.Style.plain, target: self, action: #selector(back_buttonAction))
        navigationItem.leftBarButtonItem = leftBarButton
        segmentControl.ensureiOS12Style()
        segmentControl2.ensureiOS12Style()
        viewModel.getData()
    }
    
    //MARK:- user interactions
    @objc func back_buttonAction() {
        
        viewModel.routeToDashboard()
    }
    
    @IBAction func segmentToggle(_ sender: UISegmentedControl) {
        viewModel.segmentValueChange(index: sender.selectedSegmentIndex)
    }
}

// MARK: - protocol implementations
extension DailyAdjViewController: DailyAdjViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        RedundantFunctions.init().showStaticAlert(title, message: message, onViewController: self)
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
    
    func setSegmentHeaders(titles:[String]) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            for index in 0...titles.count-1 {
                self.segmentControl.setTitle(titles[index], forSegmentAt: index)
            }
        })
    }
    
    func reloadData() {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.segmentControl.isHidden = false
            self.segmentControl2.isHidden = false
            self.tableView.reloadData()
        })
    }
}

//MARK: - tableView delegate and datasource functions
extension DailyAdjViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: STRINGS.CELLS.DAILYADJ) as! DailyAdjCell
        let data = viewModel.getData(for: indexPath.row)
        cell.date_lbl.text = data[0]
        cell.c1_lbl.text = data[1]
        cell.c2_lbl.text = data[2]
        cell.c3_lbl.text = data[3]
        return cell
    }
}

extension DailyAdjViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
