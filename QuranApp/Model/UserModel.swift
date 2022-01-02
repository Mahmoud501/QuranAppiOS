//
//  UserModel.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class UserModel {
    
    var name: String?
    var phone: String?
    var age: String?
    var location: String?
    var id: Int?
    
    init() { }
    
    init(api_model: [String: Any]?) {
        self.name = api_model?["name"] as? String
        self.phone = api_model?["phone"] as? String
        self.age = api_model?["age"] as? String
        self.location = api_model?["location"] as? String
        self.id = api_model?["id"] as? Int
    }
    
    
    static var current: UserModelInfo? {
        get {
            let repo = CoreDataRepository<CSetting>.init()
            let setting = repo.getAll()
            let userData = setting?.first?.user
            let jsonData = userData?.data(using: .utf8)
            let decoder = JSONDecoder()
            return try? decoder.decode(UserModelInfo.self, from: jsonData ?? Data())

        }
    }
}


struct UserModelInfo: Codable {
    
    var name: String?
    var phone: String?
    var age: String?
    var location: String?
    var id: Int?
    
    init() { }
    
    init(user: UserModel) {
        self.name = user.name
        self.phone = user.phone
        self.age = user.age
        self.location = user.location
        self.id = user.id
    }

}
