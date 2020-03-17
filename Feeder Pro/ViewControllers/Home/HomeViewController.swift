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
    
    //Declarations
    lazy var countryPicker: CountryPickPopOverViewController = {
        let controller = CountryPickPopOverViewController()
        //controller.delegate = self
        
        controller.modalPresentationStyle = .popover
        controller.preferredContentSize = CGSize(width: 250, height: 320)
        return controller
    }()
    private var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fetchTopHeadLines()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        //countryPicker.delegate = self
        
        present(countryPicker, animated: true, completion: nil)
        
    }
    
    func dismisscountryPickerPopoverController(){
        self.countryPicker.dismiss(animated: false)
    }
    
}


// MARK: - TableView Delegates
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: "TrendingTableViewCell", bundle: nil), forCellReuseIdentifier: "TrendingTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell", for: indexPath) as! TrendingTableViewCell
        
        cell.selectionStyle = .none
        
        cell.cellData = self.articles

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 330
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
}
//API Calls
extension HomeViewController{
    
    func fetchTopHeadLines(){
        
        indicator.show()
        DataManager.shared.getTopHeadLines() { (apiStatus, message, articles) in
            DispatchQueue.main.async {
                indicator.hide()
                if apiStatus != .ok{
                    print("ERROR:\(message)")
                }else{
                    self.articles = articles ?? [Article]()
                    self.tableView.reloadData()
                }
            }
            
        }
        
    }
    
}
