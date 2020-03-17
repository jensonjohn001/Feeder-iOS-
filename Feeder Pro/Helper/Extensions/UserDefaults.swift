//
//  UserDefaults.swift
//  BookYourSlot
//
//  Created by STMAC002 on 06/03/20.
//  Copyright © 2020 StMac001. All rights reserved.
//

import Foundation
import UIKit


extension UserDefaults {
    
    
    fileprivate static var storage: UserDefaults {
        get {
            return UserDefaults.standard
        }
    }
    
    
    static func getvalue(forKey: String) -> Any? {
        
        return storage.value(forKey: forKey)
    }
    
    
    static func save(_ value: Any?, forKey: String, isReadyToCommit: Bool) {
        
        storage.set(value, forKey: forKey)
        if isReadyToCommit {
            
            synchronize()
        }
    }
    
    
    static func removeObject(forKey: String, isReadyToCommit: Bool) {
        
        storage.removeObject(forKey: forKey)
        if isReadyToCommit {
            
            synchronize()
        }
    }
    
    
//    static func existsValue(forkey: UserDefaultsKey ) -> Bool {
//
//        return storage.object(forKey: forkey.name) != nil
//    }
    
    
    fileprivate static func synchronize() {
        
        storage.synchronize()
    }
    
    
    static func saveAsData<T: Encodable>(_ value: T?, forKey: String, isReadyToCommit: Bool) {
        
        guard let data = try? JSONEncoder().encode(value) else {
            return
        }
        save(data, forKey: forKey, isReadyToCommit: isReadyToCommit)
    }
    
    
    static func getValueFromData<T: Decodable>(forKey: String) -> T? {
        
        guard let data = getvalue(forKey: forKey) as? Data else {
          
            return nil
        }
        guard let value: T = try? JSONDecoder().decode(T.self, from: data) else {
            
            return nil
        }
        return value
    }
}
