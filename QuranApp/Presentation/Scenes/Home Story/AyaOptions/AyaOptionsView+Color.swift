//
//  AyaOptionsView+Color.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/19/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension AyaOptionsView {
    
    static var NeedReviewColor: UIColor {
        return UIColor.systemBlue.withAlphaComponent(0.2)
    }
 
    static var AlwaysForgetSomthingColor: UIColor {
        return UIColor.systemYellow.withAlphaComponent(0.3)
    }
    
    static var AlwaysWrongColor: UIColor {
        return UIColor.systemRed.withAlphaComponent(0.3)
    }
    
    
    static func getBackgroundColor(index: String) -> UIColor? {
        if index == "0" {
            return AyaOptionsView.NeedReviewColor
        }else if index == "1" {
            return AyaOptionsView.AlwaysForgetSomthingColor
        }else if index == "2" {
            return AyaOptionsView.AlwaysWrongColor
        }else {
            return nil
        }
    }
    
    
    func setColorToAyat(index: String) {
        let ayahRepo = CoreDataRepository<CAyatModel>.init()
        for item in self.orderAyat ?? [] {
            item.color = index
            ayahRepo.register(value: item)
        }
        colorAyat?()        
    }
}
