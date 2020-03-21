//
//  HomeViewController.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var countryImageView: UIImageView!
    @IBOutlet var countryCodeLabel: UILabel!
    
    //Declarations
    lazy var countryPicker: CountryPickPopOverViewController = {
        let controller = CountryPickPopOverViewController()
        controller.delegate = self
        
        controller.modalPresentationStyle = .popover
        controller.preferredContentSize = CGSize(width: 250, height: 320)
        return controller
    }()
    private var articlesDictionary: [Int:[Article]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSelectedCountry()
        fetchTopHeadLines()
    }

}

// MARK: - Local funcions
extension HomeViewController{
    
    func loadSelectedCountry(){
        let selectedCountry = AppConfiguration.selectedCountry ?? .India
        self.countryImageView.image = UIImage(named: selectedCountry.value)
        self.countryCodeLabel.text = selectedCountry.value.uppercased()
        
    }
    
}
// MARK: - Button Actions
extension HomeViewController{
    
    @IBAction func countryButtonAction(_ sender: UIButton){
        presentCountryPickerController(sender)
    }
    
    
    func presentCountryPickerController(_ source: UIButton) {
        
        /*  iPAD known issue
         *  Popover instance is created all the times
         *  To overcome it - We have to reset the popover configuration before each present
         */
        countryPicker.popoverPresentationController?.permittedArrowDirections = [.up]
        countryPicker.popoverPresentationController?.sourceView = source
        countryPicker.popoverPresentationController?.sourceRect = source.bounds
        countryPicker.delegate = self
        
        present(countryPicker, animated: true, completion: nil)
        
    }
    
    func dismisscountryPickerPopoverController(){
        self.countryPicker.dismiss(animated: false)
    }
    
}


// MARK: - TableView Delegates
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0{
            return 1
        }else{
            let cellData = self.articlesDictionary[section]
            return cellData?.count ?? 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            //Trending news row
            tableView.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
            
            cell.selectionStyle = .none
            
            let cellData = self.articlesDictionary[indexPath.section]
            
            cell.cellData = cellData
            
            return cell
        }else{
            
            tableView.register(UINib(nibName: "OtherNewsTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherNewsTableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "OtherNewsTableViewCell", for: indexPath) as! OtherNewsTableViewCell
            
            cell.selectionStyle = .none
            
            let cellData = self.articlesDictionary[indexPath.section]
            
            cell.cellData = cellData?[indexPath.row]
            
            return cell
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 330
        }else{
             return 135
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.articlesDictionary.keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection: Int) -> CGFloat {
        
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection: Int) -> UIView? {
        
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell") as! HeaderTableViewCell
        
        var sectionName = ""
        switch viewForHeaderInSection{
        case 0: sectionName = "Trending"
        case 1: sectionName = "Technology"
        case 2: sectionName = "Business"
        default:
            sectionName = "Other News"
        }
        
        cell.titleLabel.text = sectionName
        
        return cell
        
    }
    
}
//API Calls
extension HomeViewController{
    
    func fetchTopHeadLines(){
        self.articlesDictionary.removeAll()
        indicator.show()
        DataManager.shared.getTopHeadLines() { (apiStatus, message, articles) in
            DispatchQueue.main.async {
                indicator.hide()
                if apiStatus != .ok{
                    print("ERROR:\(message)")
                }else{
                    //Saving trending news
                    self.articlesDictionary[0] = articles
                    
                    //Fetching other category news
                    self.fetchOtherNews(category: .technology) { (technologyNews) in
                        self.articlesDictionary[1] = technologyNews
                        self.fetchOtherNews(category: .business) { (businessNews) in
                            self.articlesDictionary[2] = businessNews
                             self.tableView.reloadData()
                        }
                    }
                }
            }
            
        }
        
    }
    
    
    func fetchOtherNews(category:NewsCategory, completion: @escaping (_ categoryNews: [Article]) -> () ){
        
        indicator.show()
        DataManager.shared.getLatestNews(for: category) { (apiStatus, message, articles) in
            DispatchQueue.main.async {
                indicator.hide()
                if apiStatus != .ok{
                    print("ERROR:\(message)")
                    completion(articles ?? [Article]())
                }else{
                    completion(articles ?? [Article]())
                   
                }
            }
            
        }
        
    }
    
    
    
}
extension HomeViewController:CountryPickPopOverViewControllerDelegate{
    func didChooseCountry(_ country: Country) {
        loadSelectedCountry()
        fetchTopHeadLines()
    }
    
    
}
