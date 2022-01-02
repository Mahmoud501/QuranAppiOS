//
//  UIApp+Lang.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/29/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    static var isArabic : Bool {
        return (UserDefaults.standard.object(forKey: "loclz") as? String) == "ar"
    }
    
    static var currentLang: String? {
        get { (UserDefaults.standard.object(forKey: "loclz") as? String) }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: "loclz")
        }
    }
}
