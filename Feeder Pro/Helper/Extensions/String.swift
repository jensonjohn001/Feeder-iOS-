//
//  String.swift
//  BookYourSlot
//
//  Created by STMAC002 on 05/03/20.
//  Copyright © 2020 StMac001. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    // Calculate Size
    func textSize(of font: UIFont) -> CGSize {
        
        let size = self.size(withAttributes: [NSAttributedString.Key.font : font])
        return size
    }
}

/*
 Author  : Hepsi Sam
 Date    : 05 Mar 2020
 purpose : Validate Email
 Reference : https://stackoverflow.com/a/52282751
 */
extension String {
    func isValidEmail() -> Bool {
        let regex = try? NSRegularExpression(pattern: "^(((([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])+(\\.([a-zA-Z]|\\d|[!#\\$%&'\\*\\+\\-\\/=\\?\\^_`{\\|}~]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])+)*)|((\\x22)((((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(([\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x7f]|\\x21|[\\x23-\\x5b]|[\\x5d-\\x7e]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])|(\\([\\x01-\\x09\\x0b\\x0c\\x0d-\\x7f]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}]))))*(((\\x20|\\x09)*(\\x0d\\x0a))?(\\x20|\\x09)+)?(\\x22)))@((([a-zA-Z]|\\d|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])|(([a-zA-Z]|\\d|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])([a-zA-Z]|\\d|-|\\.|_|~|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])*([a-zA-Z]|\\d|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])))\\.)+(([a-zA-Z]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])|(([a-zA-Z]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])([a-zA-Z]|\\d|-|_|~|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])*([a-zA-Z]|[\\x{00A0}-\\x{D7FF}\\x{F900}-\\x{FDCF}\\x{FDF0}-\\x{FFEF}])))\\.?$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    func isValidName() -> Bool{
        let regex = try? NSRegularExpression(pattern: "^[\\p{L}\\.]{2,30}(?: [\\p{L}\\.]{2,30}){0,2}$", options: .caseInsensitive)
        
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
}


extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ssZ")-> Date?{

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date

    }
}
