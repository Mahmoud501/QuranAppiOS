//
//  WriteTestVC+func.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/8/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension WriteTestVC {
        
    func testAll(withMark: Bool)-> (String, String, Bool)? {
        var flag = true
        let ayat = self.txtText.text.split(separator: "@")
        var answer1 = ""
        var answer2 = ""
        for i in 0 ..< orderAyat!.count {
            var currentAyah = ""
            var currentSimpleAyah = ""
            var currentFlag = true
            if i >= ayat.count {
                let tuple = WriteTestVC.checkText(ayah: orderAyat?[i], testString: " ")
                flag = false
                currentFlag = false
                currentSimpleAyah = (tuple?.0 ?? "")
                currentAyah = (tuple?.1 ?? "")
                answer1 = answer1 + (tuple?.0 ?? "")  + "\n\n"
                answer2 = answer2 + (tuple?.1 ?? "")  + "\n\n"
            }else {
                let tuple = WriteTestVC.checkText(ayah: orderAyat?[i], testString: ayat[i].description)
                if flag == true {
                    flag = tuple?.2 ?? false
                }
                currentFlag = tuple?.2 ?? false
                currentSimpleAyah = (tuple?.0 ?? "")
                currentAyah = (tuple?.1 ?? "")
                answer1 = answer1 + (tuple?.0 ?? "")  + "\n\n"
                answer2 = answer2 + (tuple?.1 ?? "")  + "\n\n"
            }            
            if withMark == true  {
                if currentFlag == true {
                    orderAyat?[i].error = ""
                    orderAyat?[i].simple_error = ""
                }else {
                    orderAyat?[i].error = currentAyah
                    orderAyat?[i].simple_error = currentSimpleAyah
                }
            }
        }
        return (answer1, answer2, flag)
    }
    
    
    
}
