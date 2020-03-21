//
//  Enum.swift
//  BookYourSlot
//
//  Created by STMAC002 on 05/03/20.
//  Copyright © 2020 StMac001. All rights reserved.
//

import Foundation

enum ApiStatus: String{
    case ok = "ok"
    case fail = "fail"
    case none = "none"
    
    var value: String {
        return self.rawValue
    }
}


enum Country: String, Codable{
    
    case Argentina = "ar"
    case Australia = "au"
    case Austria = "at"
    case Belgium = "be"
    case Brazil = "br"
    case Bulgaria = "bg"
    case Canada = "ca"
    case China = "cn"
    case Colombia = "co"
    case Cuba = "cu"
    case CzechRepublic = "cz"
    case Egypt = "eg"
    case France = "fr"
    case Germany = "de"
    case Greece = "gr"
    case HongKong = "hk"
    case Hungary = "hu"
    case India = "in"
    case Indonesia = "id"
    case Ireland = "ie"
    case Israel = "il"
    case Italy = "it"
    case Japan = "jp"
    case Latvia = "lv"
    case Lithuania = "lt"
    case Malaysia = "my"
    case Mexico = "mx"
    case Morocco = "ma"
    case Netherlands = "nl"
    case NewZealand = "nz"
    case Nigeria = "ng"
    case Norway = "no"
    case Philippines = "ph"
    case Poland = "pl"
    case Portugal = "pt"
    case Romania = "ro"
    case Russia = "ru"
    case SaudiArabia = "sa"
    case Serbia = "rs"
    case Singapore = "sg"
    case Slovakia = "sk"
    case Slovenia = "si"
    case SouthAfrica = "za"
    case SouthKorea = "kr"
    case Sweden = "se"
    case Switzerland = "ch"
    case Taiwan = "tw"
    case Thailand = "th"
    case Turkey = "tr"
    case UAE = "ae"
    case Ukraine = "ua"
    case UnitedKingdom = "gb"
    case UnitedStates = "us"
    case Venuzuela = "ve"
    
    case none = "none"
    
    var value: String {
        return self.rawValue
    }
    var caseName: String {
        return Mirror(reflecting: self).children.first?.label ?? String(describing: self)
    }
}


// Support User Defaults save
enum UserDefaultsKey: String {
    
    case countrySelected

    var name: String {
        return self.rawValue
    }
}

enum NewsCategory: String{
    case trending
    case business
    case entertainment
    case health
    case science
    case sports
    case technology

    var name: String {
        return self.rawValue
    }
}
