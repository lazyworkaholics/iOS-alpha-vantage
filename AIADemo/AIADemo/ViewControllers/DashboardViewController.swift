//
//  ViewController.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 20/05/2021.
//

import UIKit

class DashboardViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    //MARK:- iboutlets and variables
    var viewModel: DashboardViewModel!
    
    @IBOutlet var searchBar:UITextField!
    @IBOutlet var segmentControl:UISegmentedControl!
    @IBOutlet var collectionView:UICollectionView!
    @IBOutlet var collectionNilLabel:UILabel!

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
        
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.SETTINGS), style: UIBarButtonItem.Style.plain, target: self, action: #selector(settings_buttonAction))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        self.setupUI()
    }
    
    func setupUI() {
        
        let width = (view.frame.width - 100)/2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
        
        segmentControl.ensureiOS12Style()
        if viewModel.getDashboardCompaniesCount() == 0 {
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
    
    //MARK:- user interactions
    @objc func settings_buttonAction() {
        
        viewModel.routeTosettingsView()
    }
    
    @objc func dailyAdj_buttonAction() {
        
        viewModel.routeToDailyView()
    }
    
    @IBAction func searchTextChange(_ sender: UITextField) {
        
        if sender.isFirstResponder {
            viewModel.searchforCompanies(keyword: sender.text!)
        }
    }
    
    @IBAction func segmentToggle(_ sender: UISegmentedControl) {
        
        viewModel.segmentValueChange(index: sender.selectedSegmentIndex)
    }
}

// MARK: - protocol implementations
extension DashboardViewController: DashboardViewModelProtocol {
    
    func isRightBarButtonHidden(isHidden:Bool) {
        
        if isHidden {
            self.navigationItem.rightBarButtonItem = nil
        } else {
            let rightBarButton = UIBarButtonItem.init(image: UIImage.init(named: STRINGS.NEXT), style: UIBarButtonItem.Style.plain, target: self, action: #selector(dailyAdj_buttonAction))
            self.navigationItem.rightBarButtonItem = rightBarButton
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            self.segmentControl.isHidden = false
            self.collectionView.isHidden = false
            self.collectionNilLabel.isHidden = true
            self.collectionView.reloadData()
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
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func dismissSearchKeyboard() {
        
        self.searchBar.resignFirstResponder()
    }
    
    func clearSearchText() {
        
        self.searchBar.text = ""
    }
}

//MARK: - textField delegate functions
extension DashboardViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        viewModel.searchforCompanies(keyword: textField.text!)
    }
}

//MARK: - collection view delegate and datasource functions
extension DashboardViewController: UICollectionViewDataSource {
   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.getDashboardCompaniesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: STRINGS.CELLS.COLLECTION, for: indexPath) as! CollectionCell
        
        cell.name_lbl.text = viewModel.getDashboardCompanyName(for: indexPath.row)
        cell.symbol_lbl.text = viewModel.getDashboardCompanySymbol(for: indexPath.row)
        cell.delete_btn.tag = indexPath.row
        cell.selected_Image.isHidden = !viewModel.isDailyAdjustChecked(index: indexPath.row)
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.borderWidth = 1
        cell.contentView.layer.borderColor = UIColor.init(named: STRINGS.COLORS.NAVIGATION)?.cgColor
   
        return cell
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.companySelected(at: indexPath.row)
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        
        RedundantFunctions.init().showDoubleActionAlert(STRINGS.DELETE_FROM_DASHBOARD, message: "", firstTitle: STRINGS.YES, secondTitle: STRINGS.NO, onfirstClick: {
            self.viewModel.removeSearchItem(at: sender.tag)
        }, onSecondClick: {}, onViewController: self)
        
    }
}
