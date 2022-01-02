//
//  NSConstraint.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/21/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    
    static var bottomSafe: CGFloat {
        get {

            var bottom: CGFloat = 0
                   
            if #available(iOS 11.0, *) {
            
                let window = UIApplication.shared.keyWindow
                
                bottom = window?.safeAreaInsets.bottom ?? 0
                
            }
            return bottom
            
        }
    }
    
    
}
