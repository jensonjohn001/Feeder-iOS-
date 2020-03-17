//
//  Articles.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
struct NewsData: Codable {
    
    var status: String?
    var articles: [Article]?
    var message: String?
    
    // Computed Values
    var apiStatus: ApiStatus {
        return ApiStatus(rawValue: status ?? "none") ?? .none
    }
}
struct Article: Codable {
    var source:Source?
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?

    struct Source: Codable{
        var id:String?
        var name:String?
        
    }
}
