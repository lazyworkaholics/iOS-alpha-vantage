//
//  DailyAdjViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 22/05/2021.
//

import UIKit

class DailyAdjViewController: UIViewController {

    //MARK:- iboutlets and variables
    @IBOutlet var segmentControl:UISegmentedControl!
    @IBOutlet var segmentControl2:UISegmentedControl!
    @IBOutlet var tableView:UITableView!
    @IBOutlet var activityindicator: UIActivityIndicatorView!
    
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

        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.BACK), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DailyAdjViewController.back_buttonAction))
        navigationItem.leftBarButtonItem = leftBarButton
        
        viewModel.getData()
    }
    
    @objc func back_buttonAction() {
        
        viewModel.navigateToDashboard()
    }
    
    @IBAction func segmentToggle(_ sender: UISegmentedControl) {
        viewModel.segmentValueChange(index: sender.selectedSegmentIndex)
    }
}

extension DailyAdjViewController: DailyAdjViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        
    }
    
    func showLoadingIndicator() {
        
    }
    
    func hideLoadingIndicator() {
        
    }
    
    func setSegmentHeaders(titles:[String]) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            var index = 0
            for title in titles {
                self.segmentControl.setTitle(title, forSegmentAt: index)
                index += 1
            }
        })
    }
    
    func showTableView() {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.segmentControl.isHidden = false
            self.segmentControl2.isHidden = false
            self.tableView.reloadData()
        })
    }
}

extension DailyAdjViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyAdjCell") as! DailyAdjCell
        let data = viewModel.getData(for: indexPath.row)
        cell.date_lbl.text = data.date
        cell.c1_lbl.text = data.open_c1
        cell.c2_lbl.text = data.open_c2
        cell.c2_lbl.text = data.open_c2
        return cell
    }
}

extension DailyAdjViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
