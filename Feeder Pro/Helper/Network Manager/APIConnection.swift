//
//  APIConnection.swift
//  BookYourSlot
//
//  Created by STMAC002 on 05/03/20.
//  Copyright © 2020 StMac001. All rights reserved.
//

import Foundation

var baseURL: String = "http://newsapi.org/v2/"
let apiKey: String = "ef5b910bb4a047d289c7366e96d9d9df"

// Endpoint URL's
enum APIEndpoint: String {
    
    var string: String {
        return self.rawValue
    }

   case topHeadLines = "top-headlines"
    
}


// Support Keys in GET and POST
struct GetPostKeys {
    
    // Support Header
    let contentType = "Content-Type"
    let authorization = "authorization"
    let country = "country"
    let apiKey = "apiKey"
    
}
