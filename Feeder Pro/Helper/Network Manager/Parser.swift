//
//  Parser.swift
//  BookYourSlot
//
//  Created by STMAC002 on 05/03/20.
//  Copyright © 2020 StMac001. All rights reserved.
//

import Foundation
struct Parser {
    
    static func parse<T: Decodable>(_ data: Data?, apiEndpoint: APIEndpoint) -> T? {
        
        // Validation
        guard let _data = data else {
            
            if logActivity { print(Messages().emptyData) }
            return nil
        }
        
        // Parsing
        do {
            let modal = try JSONDecoder().decode(T.self, from: _data)
            return modal
        } catch {
            
            
            print(error)
            return nil
        }
    }
}
