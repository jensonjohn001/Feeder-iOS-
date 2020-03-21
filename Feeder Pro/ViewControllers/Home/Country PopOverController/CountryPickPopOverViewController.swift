//
//  CountryPickPopOverViewController.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

protocol CountryPickPopOverViewControllerDelegate:class {
    func didChooseCountry(_ country:Country)
}

class CountryPickPopOverViewController: UIViewController {
    
    // MARK: Connection Objects
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    //Set from parent
    weak var delegate:CountryPickPopOverViewControllerDelegate?
    
    //Declaration
    var countries = [CountryModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setSelectedCountry()
    }
    
    func setSelectedCountry(){
        self.countries = getAllCountries()
        
        let selectedCountry = AppConfiguration.selectedCountry ?? .India
        if let selectedIndex = self.countries.firstIndex(where: {$0.country == selectedCountry }){
            self.countries[selectedIndex].isSelected = true
        }
        
        self.tableView.reloadData()
    }


    func getAllCountries()->[CountryModel]{
    
        var countries = [CountryModel]()
        for country in allCountries{
            var countryModel = CountryModel()
            countryModel.country = country
            countryModel.countryName = country.caseName
            countryModel.isSelected = false
            countries.append(countryModel)
        }
        return countries
    }
    
    func getSelectedCountry()->Country{
        for country in self.countries{
            if country.isSelected ?? false{
                return country.country ?? .India
            }
        }
        return .India
    }
    
    func deSelectAllCountries(){
        for (index,_) in self.countries.enumerated(){
            self.countries[index].isSelected = false
        }
    }
    
    func isValidSelection()->Bool{
        for country in self.countries{
            if !(country.isSelected ?? false){
                return false
            }
        }
        return true
    }
    
    func changeDoneButton(_ status: Bool){
        self.doneButton.isUserInteractionEnabled = status
        self.doneButton.backgroundColor = status ? #colorLiteral(red: 0, green: 0.4745098039, blue: 0.7450980392, alpha: 1) : #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
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
        let countryCode = cellData.country?.value
        cell.countryImageView.image = UIImage(named: countryCode ?? "in")
        cell.countryName.text = cellData.countryName
        cell.selectedImageView.isHidden = (cellData.isSelected ?? false) ? false : true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deSelectAllCountries()
        var cellData = self.countries[indexPath.row]
        cellData.isSelected = true
        self.countries[indexPath.row] = cellData
        self.tableView.reloadData()
    }
    
    
}
// MARK: - Button actions
extension CountryPickPopOverViewController{
    
    @IBAction func doneButtonAction(_ sender: UIButton){
        
        let selectedCountry = self.getSelectedCountry()
        AppConfiguration.selectedCountry = selectedCountry
        self.delegate?.didChooseCountry(AppConfiguration.selectedCountry ?? .India)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}
