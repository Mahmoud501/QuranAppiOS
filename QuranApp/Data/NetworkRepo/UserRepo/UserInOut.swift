//
//  UserInOut.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

struct UserInOut {
    
    struct Create {
        
        struct Request: Encodable {
            var phone: String?
            var age: String?
            var location: String?
            var name: String?
            var device_type: String? //0 ios , 1 android
            var device_token: String?
        }
        
      
        struct ViewModel {
            var user: UserModel?
            var code: Int?
            var message: String?
        }
        
    }
    
    
}

