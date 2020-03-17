//
//  CountryPickPopOverViewController.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class CountryPickPopOverViewController: UIViewController {
    
    // MARK: Connection Objects
    @IBOutlet weak var tableView: UITableView!
    
    //Declaration
    var countries = [CountryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.countries = getAllCountries()
        self.tableView.reloadData()
    }


    func getAllCountries()->[CountryModel]{
    
        var countries = [CountryModel]()
        for country in allCountries{
            var countryModel = CountryModel()
            countryModel.countryCode = country.value
            countryModel.countryName = country.caseName
            countryModel.isSelected = false
            countries.append(countryModel)
        }
        return countries
    }

}
// MARK: - TableView Delegates
extension CountryPickPopOverViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.register(UINib(nibName: "CountryTableViewCell", bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath) as! CountryTableViewCell
        cell.selectionStyle = .none
        
        let cellData = self.countries[indexPath.row]
        let countryCode = cellData.countryCode
        cell.countryImageView.image = UIImage(named: countryCode ?? "in")
        cell.countryName.text = cellData.countryName
        cell.selectedImageView.isHidden = (cellData.isSelected ?? false) ? false : true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
}
