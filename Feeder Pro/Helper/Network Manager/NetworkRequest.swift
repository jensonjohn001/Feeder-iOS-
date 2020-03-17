//
//  NetworkRequest.swift
//  BookYourSlot
//
//  Created by STMAC002 on 05/03/20.
//  Copyright © 2020 StMac001. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Network {
    
    // Declarations
    fileprivate let messages = Messages()
    fileprivate let keys = GetPostKeys()
    
    
    func request(to:APIEndpoint, method:HTTPMethod, headers: HTTPHeaders, pathParams: PathParameters, parameters: Parameters, queryParameters: Parameters, completion: @escaping (_ networkStatus: Bool, _ responseStatus: Bool, _ data: Data?) -> ()) {
        // Connection Validation
        guard Reachability().isConnected() else {
            
            if logActivity { print(messages.noConnection) }
            return completion(false, false, nil)
        }
        
        //Generate complete URL
        guard let fullURL = getFullURL(endpoint:to, pathParams: pathParams, queryParameters:queryParameters) else {
            if logActivity { print(messages.urlCreationFailed) }
            return completion(true, false, nil)
        }
        
        
        //Generate header
        let fullHeaders = generateHeaders(headers)
        
        // Log
        if logActivity {
            
            print("--------------- Request URL, Body & Response ----------------")
            print("Request URL: \(String(describing: fullURL))")
            print("Request Headers: \(String(describing: JSON(fullHeaders.dictionary)))")
            print("Request Parameters: \(String(describing: JSON(parameters)))")
        }
        
        
        AF.request(fullURL ,method: method , parameters: parameters, headers: fullHeaders).responseData { response in
            
            print("Response: \(String(describing: JSON(response.data ?? Data())))")
            print("--------------- --------------------------- ----------------")
            // Validation
            if let _error = response.error {
                
                if logActivity {
                    
                    if logActivity { print(self.messages.badServerResponse, "\n\n") }
                    print(_error)
                }
                completion(true, false, nil)
            }
            
            // Notify parent with response data
            completion(true, true, response.data)
            
        }
        
    }
}
extension Network{
    
    
    fileprivate func getFullURL(endpoint:APIEndpoint, pathParams: PathParameters, queryParameters: Parameters)->String?{
        var fullURL = baseURL + bindPathParamsAndGeneratePath(from: pathParams, path: endpoint)
        if queryParameters.count > 0{
            fullURL += "?"
            for (key, value) in queryParameters {
                if let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
                    let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    fullURL.append(encodedKey + "=" + "\(encodedValue)" + "&")
                } else {
                    print("Could not urlencode parameters")
                    return nil
                }
            }
            fullURL.removeLast()
        }
        return fullURL
    }
    
    func bindPathParamsAndGeneratePath(from params: PathParameters, path: APIEndpoint) -> String {
        
        if params.count > 0 {
            
            var path = path.string
            for (key, value) in params {
                
                path = path.replacingOccurrences(of: "{\(key)}", with: value)
            }
            return path
        } else {
            
            return path.string
        }
    }
    
    // Support Authentication
    fileprivate func generateHeaders(_ header: HTTPHeaders) -> HTTPHeaders {
        
        var updatedHeaders = header
        updatedHeaders.add(name: keys.contentType, value: "application/json")
        return updatedHeaders
    }
}
