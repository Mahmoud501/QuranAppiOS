//
//  ArabicCollectio.swift
//  BioSmartApp
//
//  Created by Mahmoud on 2/10/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

class ArabicFlowlayout : UICollectionViewFlowLayout {
    
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        let lang = UserDefaults.standard.object(forKey: "loclz") as? String
        if lang == "en" {
            return false
        }
        return true
    }
    
    
}
