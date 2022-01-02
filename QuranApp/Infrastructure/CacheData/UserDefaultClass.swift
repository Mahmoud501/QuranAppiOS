//
//  UserDefaultClass.swift
//  MatjrApp
//
//  Created by Mahmoud on 1/19/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation

//documatation
//
//
//

class UserDefaultClass
{
    static func getValue(_ str: String) -> Any?
    {
        return UserDefaults.standard.object(forKey: str)
    }
    
    static func setValue(_ key: String, _ value: Any?)
    {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    //save all object in userdefaults
    static func setObject<T>(_ key: String, _ value: T?) where T : Encodable
    {
        if value == nil {
            UserDefaults.standard.set(nil, forKey: key)
        }else {
            let jsonEncoder = JSONEncoder()
            let jsonData = try? jsonEncoder.encode(value!)
            let json = String(data: jsonData!, encoding: String.Encoding.utf8)
            UserDefaults.standard.set(json, forKey: key)
        }
    }
    
    //get all object in userdefaults
        static func getObject<T: Codable>(_ key: String, result: T.Type) -> T?
        {
            let jsonString = UserDefaultClass.getValue(key) as? String
            let jsonData = jsonString?.data(using: .utf8)
            let decoder = JSONDecoder()
             return try? decoder.decode(result, from: jsonData ?? Data())
       }
 
}

