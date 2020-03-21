//
//  AppConfigurations.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation


enum AppConfiguration {
    
    static var selectedCountry: Country? {
        
        set(newCountry) {
        
            UserDefaults.save(newCountry?.value, forKey: UserDefaultsKey.countrySelected.name, isReadyToCommit: true)
        }
        get {
            if let country = UserDefaults.getvalue(forKey: UserDefaultsKey.countrySelected.name) as? String{
                return Country(rawValue: country) 
            }
            return .India
        }
    }
    
    
}
