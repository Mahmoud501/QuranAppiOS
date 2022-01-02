//
//  CompeleteVC+func.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/10/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

extension CompleteVC {
    
    func calCount() -> Int {
        let num = Int(((self.ayat?.count ?? 0) * 20) / 100)
        return num <= 0 ? 1 : num
    }
    
    func getAyatCompleteIds() -> [String] {
        let count = calCount()
        let last_item = (ayat?.count ?? 0) - 1
        let arr = ayat?.shuffled()
        if (last_item - count) <= 0 {
            return ayat?.map{ $0.id ?? "" } ?? []
        }else {
            let completeAyat = arr?[((last_item - count) + 1)...last_item]
            return completeAyat?.map{ $0.id ?? "" } ?? []
        }
        
    }
    
    
    
}
