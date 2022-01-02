//
//  JuzhManger.jwift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/5/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class JuzhManger {
    

    private func handleStartJuzh(arr: [CJuzh]) -> [CJuzh]{
        var i: Int32 = 1
        for item in arr {
            item.start = i
            i += item.number_ayat
        }
        return arr
    }

    func installJuzh() -> [CJuzh] {
            var arr = [CJuzh]()
            
            let repo = CoreDataRepository<CJuzh>.init()
            let j1 = CJuzh.init(context: repo.context!)
            j1.id = "1"
            j1.name_ar = "الجزء الاول"
            j1.number_ayat = 148
            arr.append(j1)
            
            let j2 = CJuzh.init(context: repo.context!)
            j2.id = "2"
            j2.name_ar = "الجزء الثاني"
            j2.number_ayat = 111
            arr.append(j2)
            
            let j3 = CJuzh.init(context: repo.context!)
            j3.id = "3"
            j3.name_ar = "الجزء الثالث"
            j3.number_ayat = 125
            arr.append(j3)

            let j4 = CJuzh.init(context: repo.context!)
            j4.id = "4"
            j4.name_ar = "الجزء الرابع"
            j4.number_ayat = 132
            arr.append(j4)
            
            let j5 = CJuzh.init(context: repo.context!)
            j5.id = "5"
            j5.name_ar = "الجزء الخامس"
            j5.number_ayat = 124
            arr.append(j5)

            let j6 = CJuzh.init(context: repo.context!)
            j6.id = "6"
            j6.name_ar = "الجزء السادس"
            j6.number_ayat = 111
            arr.append(j6)

            let j7 = CJuzh.init(context: repo.context!)
            j7.id = "7"
            j7.name_ar = "الجزء السابع"
            j7.number_ayat = 148
            arr.append(j7)

            
            let j8 = CJuzh.init(context: repo.context!)
            j8.id = "8"
            j8.name_ar = "الجزء الثامن"
            j8.number_ayat = 142
            arr.append(j8)
            
            
            let j9 = CJuzh.init(context: repo.context!)
            j9.id = "9"
            j9.name_ar = "الجزء التاسع"
            j9.number_ayat = 159
            arr.append(j9)

            let j10 = CJuzh.init(context: repo.context!)
            j10.id = "10"
            j10.name_ar = "الجزء العاشر"
            j10.number_ayat = 128
            arr.append(j10)

            let j11 = CJuzh.init(context: repo.context!)
            j11.id = "11"
            j11.name_ar = "الجزء الحادي عشر"
            j11.number_ayat = 150
            arr.append(j11)

            

            let j12 = CJuzh.init(context: repo.context!)
            j12.id = "12"
            j12.name_ar = "الجزء الثاني عشر"
            j12.number_ayat = 170
            arr.append(j12)

            let j13 = CJuzh.init(context: repo.context!)
            j13.id = "13"
            j13.name_ar = "الجزء الثالث عشر"
            j13.number_ayat = 154
            arr.append(j13)

            
            let j14 = CJuzh.init(context: repo.context!)
            j14.id = "14"
            j14.name_ar = "الجزء الرابع عشر"
            j14.number_ayat = 227
            arr.append(j14)
            
        
            
            let j15 = CJuzh.init(context: repo.context!)
            j15.id = "15"
            j15.name_ar = "الجزء الخامس عشر"
            j15.number_ayat = 185
            arr.append(j15)
            
            
            let j16 = CJuzh.init(context: repo.context!)
            j16.id = "16"
            j16.name_ar = "الجزء السادس عشر"
            j16.number_ayat = 269
            arr.append(j16)
            
            
            let j17 = CJuzh.init(context: repo.context!)
            j17.id = "17"
            j17.name_ar = "الجزء السابع عشر"
            j17.number_ayat = 190
            arr.append(j17)
            
            
            let j18 = CJuzh.init(context: repo.context!)
            j18.id = "18"
            j18.name_ar = "الجزء الثامن عشر"
            j18.number_ayat = 202
            arr.append(j18)
            
            
            let j19 = CJuzh.init(context: repo.context!)
            j19.id = "19"
            j19.name_ar = "الجزء التاسع عشر"
            j19.number_ayat = 339
            arr.append(j19)
            
            
            
            let j20 = CJuzh.init(context: repo.context!)
            j20.id = "20"
            j20.name_ar = "الجزء العشرون"
            j20.number_ayat = 171
            arr.append(j20)

            
            
            let j21 = CJuzh.init(context: repo.context!)
            j21.id = "21"
            j21.name_ar = "الجزء الحادي والعشرون"
            j21.number_ayat = 178
            arr.append(j21)
            
            
            let j22 = CJuzh.init(context: repo.context!)
            j22.id = "22"
            j22.name_ar = "الجزء الثاني والعشرون"
            j22.number_ayat = 169
            arr.append(j22)
            
            
            let j23 = CJuzh.init(context: repo.context!)
            j23.id = "23"
            j23.name_ar = "الجزء الثالث والعشرون"
            j23.number_ayat = 357
            arr.append(j23)
            
            
            let j24 = CJuzh.init(context: repo.context!)
            j24.id = "24"
            j24.name_ar = "الجزء الرابع والعشرون"
            j24.number_ayat = 175
            arr.append(j24)
            
            
            
            let j25 = CJuzh.init(context: repo.context!)
            j25.id = "25"
            j25.name_ar = "الجزء الخامس والعشرون"
            j25.number_ayat = 241
            arr.append(j25)
            
            
            
            let j26 = CJuzh.init(context: repo.context!)
            j26.id = "26"
            j26.name_ar = "الجزء السادس والعشرون"
            j26.number_ayat = 200
            arr.append(j26)
            
            
            let j27 = CJuzh.init(context: repo.context!)
            j27.id = "27"
            j27.name_ar = "الجزء السابع والعشرون"
            j27.number_ayat = 399
            arr.append(j27)
            
            
            
            let j28 = CJuzh.init(context: repo.context!)
            j28.id = "28"
            j28.name_ar = "الجزء الثامن والعشرون"
            j28.number_ayat = 137
            arr.append(j28)
            
            
            
            let j29 = CJuzh.init(context: repo.context!)
            j29.id = "29"
            j29.name_ar = "الجزء التاسع والعشرون"
            j29.number_ayat = 431
            arr.append(j29)
            
            
            
            let j30 = CJuzh.init(context: repo.context!)
            j30.id = "30"
            j30.name_ar = "الجزء الثلاثون"
            j30.number_ayat = 563
            arr.append(j30)

        arr = handleStartJuzh(arr: arr)
        
        return arr
    }
    
}
