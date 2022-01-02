//
//  SearchVoicePresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/26/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class SearchVoicePresenter {
    
    
    static func getAyahByVoiceText(text: String?) -> CAyatModel? {
        let text2: String? = text?.description.searchFilter.pageFliter.replacedArabicDigitsWithEnglish
            var juzhnum: Int?
            var surhaName: String?
            var pagenum: Int?
            var ayahnum: Int = 0
            var state = 0 // 1 return that current num belong to ayah or juzh
            let words = text2?.split(separator: " ")
            for item in words ?? [] {
                if state == 3 {
                    surhaName = item.description
                    state = 0
                    continue
                }
                if item.contains("جزء") == true {
                    state = 1
                }else if item.contains("اية") == true || item.contains("يا") == true {
                    state = 2
                }else if item.contains("رقم") == true {
                }else if item.contains("سورة") == true {
                    state = 3
                }else if item.contains("صفحة") == true {
                    state = 4
                }
                else if Int(item) != nil {
                    if state == 1 {
                        juzhnum = Int(item)
                    }else if state == 2 {
                        ayahnum = Int(item) ?? 0
                    }else if state == 4 {
                        pagenum = Int(item)
                    }
                }else {
                    state = 0
                }
            }
            if juzhnum != nil {
                let juzhRepo = CoreDataRepository<CJuzh>.init()
                let juzh = juzhRepo.query(with: "id == \"\(juzhnum ?? 0)\"")?.first
                ayahnum = ayahnum - 1
                if (Int(juzh?.number_ayat ?? 0) < (ayahnum + 1)) || ayahnum < 0 {
                    ayahnum = 0
                }
                return juzh?.ayat?.array[ayahnum] as? CAyatModel
            }
            else if surhaName != nil {
                let surhaRepo = CoreDataRepository<CSurha>.init()
                let surhas = surhaRepo.getAll()
                var surha: CSurha?
                for item in surhas ?? [] {
                    if item.name_ar?.searchFilter.contains(surhaName ?? "") == true {
                        surha = item
                        break
                    }
                }
                ayahnum = ayahnum - 1
                if (Int(surha?.number_ayat ?? 0) < (ayahnum + 1)) || ayahnum < 0 {
                    ayahnum = 0
                }
                return surha?.ayat?.array[ayahnum] as? CAyatModel
            }
            else if pagenum != nil {
                let pageRepo = CoreDataRepository<CPage>.init()
                let page = pageRepo.query(with: "id == \"\(pagenum ?? 0)\"")?.first
                ayahnum = ayahnum - 1
                if (Int(page?.number_ayat ?? 0) < (ayahnum + 1)) || ayahnum < 0 {
                    ayahnum = 0
                }
                return page?.ayat?.array[ayahnum] as? CAyatModel
            }
        
        
        
        return nil
    }
    
    
    
    
    
}

extension SearchVoicePresenter {
    
    func testGetAyahByVoice() {
           let testcases = [
                   "الجزء رقم ١٣",
                "جزء رقم ٣",
                "الجزء رقم ٣ الاية رقم ١",
                "جزء رقم ١ اية رقم ٣",
                "الجزء رقم ١ الأية رقم ٥",
                
        "جزء رقم ١ آية رقم ٢",
        "اية رقم ٢ جزء رقم ٢",
        "الاية رقم ٥ جزء رقم ٤١",
        "اية رقم ٢٢٢٢٢ جزء رقم ٢",
        "اية رقم ٢ جزء رقم ٢٢٢٢٤٢"
                ]
                for item in testcases {
                    let ayah = SearchVoicePresenter.getAyahByVoiceText(text: item.searchFilter.replacedArabicDigitsWithEnglish)
                    print(ayah?.desc)
                }

    }
    
}
