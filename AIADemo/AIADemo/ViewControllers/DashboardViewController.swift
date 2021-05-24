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
        
        let rightBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.SETTINGS), style: UIBarButtonItem.Style.plain, target: self, action: #selector(DashboardViewController.settings_buttonAction))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let width = (view.frame.width - 100)/2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        if viewModel.dashboardDataSource.count == 0 {
            segmentControl.isHidden = true
            collectionNilLabel.isHidden = false
            collectionView.isHidden = true
        } else {
            segmentControl.isHidden = false
            collectionNilLabel.isHidden = true
            collectionView.isHidden = false
            collectionView.reloadData()
        }
    }
    
    //MARK:- Custom Button Actions
    @objc func settings_buttonAction() {
        
        viewModel.routeTosettingsView()
    }
    
    @IBAction func searchTextChange(_ sender: Any) {
        
        if searchBar.isFirstResponder {
            viewModel.searchforCompanies(keyword: searchBar.text!)
        }
    }
    
    @IBAction func segmentToggle(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            viewModel.isIntraday = true
        } else {
            viewModel.isIntraday = false
        }
    }
}

extension DashboardViewController: DashboardViewModelProtocol {
    
    func showCollectionView() {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.segmentControl.isHidden = false
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
            self.collectionNilLabel.isHidden = true
        })
    }
    
    func hideCollectionView() {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.segmentControl.isHidden = true
            self.collectionView.isHidden = true
            self.collectionNilLabel.isHidden = false
        })
    }
    
    func showStaticAlert(_ title: String, message: String) {
        
        RedundantFunctions.init().showStaticAlert(title, message: message, onViewController: self)
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
}

//MARK: - CollectionView Delegates functions
extension DashboardViewController: UICollectionViewDataSource {
   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.dashboardDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        
        cell.name_lbl.text = viewModel.dashboardDataSource[indexPath.row].name
        cell.symbol_lbl.text = viewModel.dashboardDataSource[indexPath.row].symbol
        cell.delete_btn.tag = indexPath.row
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.init(named: "navigation")?.cgColor
   
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.companySelected(index: indexPath.row)
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
        RedundantFunctions.init().showDoubleActionAlert("Do you want to remove this company from your dashboard ?", message: "", firstTitle: STRINGS.YES, secondTitle: STRINGS.NO, onfirstClick: {
            self.viewModel.removeSearchItem(at: sender.tag)
        }, onSecondClick: {}, onViewController: self)
        
    }
}

