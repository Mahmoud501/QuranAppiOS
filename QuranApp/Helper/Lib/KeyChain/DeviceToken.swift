//
//  DeviceToken.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
 import UIKit
 import JNKeychain

 class KeychainManager: NSObject {
     static let shared = KeychainManager()

     func getDeviceIdentifierFromKeychain() -> String {

//          try to get value from keychain
         var deviceUDID = self.keychain_valueForKey("Wakeb.QuranApp") as? String
         if deviceUDID == nil {
             deviceUDID = UIDevice.current.identifierForVendor!.uuidString
//              save new value in keychain
             self.keychain_setObject(deviceUDID! as AnyObject, forKey: "Wakeb.QuranApp")
         }
         return deviceUDID!
     }

//      MARK: - Keychain

     func keychain_setObject(_ object: AnyObject, forKey: String) {
         let result = JNKeychain.saveValue(object, forKey: forKey)
         if !result {
             print("keychain saving: smth went wrong")
         }
     }

     func keychain_deleteObjectForKey(_ key: String) -> Bool {
         let result = JNKeychain.deleteValue(forKey: key)
         return result
     }

     func keychain_valueForKey(_ key: String) -> AnyObject? {
         let value = JNKeychain.loadValue(forKey: key)
         return value as AnyObject?
     }
 }

 
 
