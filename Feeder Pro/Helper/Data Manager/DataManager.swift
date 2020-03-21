//
//  DataManager.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import Foundation
import Alamofire

class DataManager: NSObject {
    
    //Declarations
    static let shared = DataManager()
    let network = Network()
    let messages = Messages()
    let keys = GetPostKeys()
    
    // MARK: Life Cycle
    private override init() {
        super.init()
        
    }
    
}
//MARK: --- Home
extension DataManager{


    func getTopHeadLines(
        completion: @escaping (_ status: ApiStatus, _ statusMessage: String, _ articles:[Article]?) -> ()){
        // Failure closure
        func failure(_ message: String) {
            
            completion(.fail, message, nil)
        }
        
        guard let apiKey = getAPIKey() else {
            failure(self.messages.apiKeyMissing)
            return
        }
        
        let endpoint:APIEndpoint = .topHeadLines
        
        let selectedCountry = AppConfiguration.selectedCountry?.value 
        
        //Query parameter
        var queryParameters = Parameters()
        queryParameters[keys.country] = selectedCountry
        queryParameters[keys.apiKey] = apiKey
        
        
        // Send Request
        network.request(to: endpoint, method: .get, headers: HTTPHeaders(), pathParams: PathParameters(), parameters: Parameters(), queryParameters: queryParameters) { (networkStatus, responseStatus, data) in
            
            /* Validations */
            
            // Network Error Case
            if !networkStatus {
                
                failure(self.messages.noConnection)
                return
            }
            
            // Parse - Success Case
            if let response: NewsData = Parser.parse(data, apiEndpoint: endpoint) {
                
                let status = response.apiStatus
                let message = response.message ?? self.messages.somethingWentWrong
                
                if status == .ok {
                    
                    completion(status, message, response.articles)
                    
                } else {
                    
                    failure(message)
                }
                return
            }
            
            // Server Error/ Parsing Error Cases
            failure(self.messages.serverNotResponding)
        }
    }
    
    
    
    func getLatestNews(for category:NewsCategory,
        completion: @escaping (_ status: ApiStatus, _ statusMessage: String, _ articles:[Article]?) -> ()){
        // Failure closure
        func failure(_ message: String) {
            
            completion(.fail, message, nil)
        }
        
        guard let apiKey = getAPIKey() else {
            failure(self.messages.apiKeyMissing)
            return
        }
        
        let endpoint:APIEndpoint = .topHeadLines
        
        let selectedCountry = AppConfiguration.selectedCountry?.value
        
        //Query parameter
        var queryParameters = Parameters()
        queryParameters[keys.country] = selectedCountry
        queryParameters[keys.apiKey] = apiKey
        queryParameters[keys.category] = category.name
        
        
        // Send Request
        network.request(to: endpoint, method: .get, headers: HTTPHeaders(), pathParams: PathParameters(), parameters: Parameters(), queryParameters: queryParameters) { (networkStatus, responseStatus, data) in
            
            /* Validations */
            
            // Network Error Case
            if !networkStatus {
                
                failure(self.messages.noConnection)
                return
            }
            
            // Parse - Success Case
            if let response: NewsData = Parser.parse(data, apiEndpoint: endpoint) {
                
                let status = response.apiStatus
                let message = response.message ?? self.messages.somethingWentWrong
                
                if status == .ok {
                    
                    completion(status, message, response.articles)
                    
                } else {
                    
                    failure(message)
                }
                return
            }
            
            // Server Error/ Parsing Error Cases
            failure(self.messages.serverNotResponding)
        }
    }
    
    
}
