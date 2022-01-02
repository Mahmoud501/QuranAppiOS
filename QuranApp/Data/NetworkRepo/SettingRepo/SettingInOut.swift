//
//  SettingInOut.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

import Foundation

struct SettingInOut {
    
    struct getAbout {
        
        struct Request: Encodable {

        }
        
      
        struct ViewModel {
            var team: [TeamMemberModel]?
            var aboutus: String?
            var code: String?
            var message: String?
        }
        
    }
    
    
    struct getSetting {
        
        struct Request: Encodable {

        }
        
      
        struct ViewModel {
            var faceook: String?
            var twitter: String?
            var last_version_ios: Int?
            var code: String?
            var message: String?
        }
        
    }
    
    
    struct contactus {
        
        struct DefaultRqeuest {
            var name: String?
            var email: String?
            var subject: String?
            var body: String?
        }
        
        struct Request: Encodable {
            
            var name: String?
            var email: String?
            var subject: String?
            var body: String?
            
        }
                   
        struct ViewModel {
            var code: String?
            var message: String?
        }
        
    }
    
    struct EmptyDown: Encodable {
        
    }
}
