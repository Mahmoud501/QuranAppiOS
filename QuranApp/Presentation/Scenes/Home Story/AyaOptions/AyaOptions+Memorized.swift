//
//  AyaOptions+Memorized.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/19/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation


extension AyaOptionsView {
    
    func isMemorizeAyat(status: Bool) {
        // 0 no , 1 yes
        let ayahRepo = CoreDataRepository<CAyatModel>.init()
        for item in self.orderAyat ?? [] {
            item.isMemorized = status
            ayahRepo.register(value: item)
        }
        memorizedAyat?()
    }
}
