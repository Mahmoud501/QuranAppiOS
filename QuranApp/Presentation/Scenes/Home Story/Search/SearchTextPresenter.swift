//
//  SearchTextPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/20/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

struct SearchItem {
    var text : String?
    var index: Int?
}

class SearchTextPresenter {
        
    var arr: [SearchItem]?
    private var type = 0 // 0 = ayah , 1 = surha , 2 = juzh , 3 = page
    private var all_arr: [String]?
    
    private var ayat: [CAyatModel]?
    private var pages: [CPage]?
    private var surhas: [CSurha]?
    private var juzhs: [CJuzh]?

    private var pageRepo: CoreDataRepository<CPage>?
    private var surhaRepo: CoreDataRepository<CSurha>?
    private var juzhRepo: CoreDataRepository<CJuzh>?
    private var ayahRepo: CoreDataRepository<CAyatModel>?
    
    init() {
        ayahRepo = CoreDataRepository<CAyatModel>()
        pageRepo = CoreDataRepository<CPage>.init()
        surhaRepo = CoreDataRepository<CSurha>.init()
        juzhRepo = CoreDataRepository<CJuzh>.init()
    }
    

    @discardableResult
     func getPages(finish: () -> ()) -> [CPage]? {
         self.pages = pageRepo?.getAll()?.sorted(by: { (p1, p2) -> Bool in
             return (Int(p1.id ?? "0") ?? 0) < (Int(p2.id ?? "0") ?? 0)
         })
        self.all_arr = self.pages?.map({($0.name_ar ?? "" ) + " - " + ($0.name_en ?? "") })
        self.arr = self.all_arr?.enumerated().map { SearchItem.init(text: $1, index: $0) }
         finish()
         return pages
     }
     
     @discardableResult
     func getSurhas(finish: () -> ()) -> [CSurha]? {
         self.surhas = surhaRepo?.getAll()?.sorted(by: { (s1, s2) -> Bool in
             return (Int(s1.id ?? "0") ?? 0) < (Int(s2.id ?? "0") ?? 0)
         })
        self.all_arr = self.surhas?.map({($0.name_ar ?? "" ) + " - " + ($0.name_en ?? "") })
        self.arr = self.all_arr?.enumerated().map { SearchItem.init(text: $1, index: $0) }
         finish()
         return surhas

     }
     
     @discardableResult
     func getJuzhs(finish: () -> ()) -> [CJuzh]? {
         self.juzhs = juzhRepo?.getAll()?.sorted(by: { (j1, j2) -> Bool in
             return (Int(j1.id ?? "0") ?? 0) < (Int(j2.id ?? "0") ?? 0)
         })
        self.all_arr = self.juzhs?.map({($0.name_ar ?? "" ) + " - " + ($0.name_en ?? "") })
        self.arr = self.all_arr?.enumerated().map { SearchItem.init(text: $1, index: $0) }
        finish()
        return juzhs
     }
    
    
    @discardableResult
        func getAyat(finish: () -> ()) -> [CAyatModel]? {
            self.ayat = ayahRepo?.getAll()?.sorted(by: { (a1, a2) -> Bool in
                return (Int(a1.id ?? "0") ?? 0) < (Int(a2.id ?? "0") ?? 0)
            })
        self.all_arr = self.ayat?.map({ ayahDesc(ayah: $0) })
           self.arr = self.all_arr?.enumerated().map { SearchItem.init(text: $1, index: $0) }
           finish()
           return ayat
        }
     
    func ayahDesc(ayah: CAyatModel?) -> String {
        let ayahdesc = ayah?.simple_desc ?? ""
        let ayahNum = ayah?.sort.description ?? ""
        let surhaName = "سورة" + " " + (ayah?.surha?.name_ar ?? "")
        let text = ayahdesc + " " + "(" + ayahNum + ")" + " " + surhaName
        return text
    }
    
    
     func resetData() {
        self.ayat = nil
        self.pages = nil
        self.surhas = nil
        self.juzhs = nil
    }
         
    func getHome(type: Int, finish: ()->()) {
        self.type = type
         resetData()
        if type == 0 {
            getAyat(finish: finish)
        }else if type == 1{
            getSurhas(finish: finish)
        }else if type == 2 {
            getJuzhs(finish: finish)
        }else {
            getPages(finish: finish)
        }
     }
    
    func getAyah(row: Int) -> CAyatModel? {
        if type == 0 {
            return self.ayat?[row]
        }else if type == 1{
            let ayat = self.surhas?[row].ayat?.array as? [CAyatModel]
            return ayat?.first
        }else if type == 2 {
            let ayat = self.juzhs?[row].ayat?.array as? [CAyatModel]
            return ayat?.first
        }else {
            let ayat = self.pages?[row].ayat?.array as? [CAyatModel]
            return ayat?.first
        }
        //return nil
    }
    
    
    func search(text: String) -> [SearchItem]? {
        let text = text.replacedArabicDigitsWithEnglish.ayahFilter2
        if text == "" {
            self.arr = self.all_arr?.enumerated().map { SearchItem.init(text: $1, index: $0) }
        }else {
            arr = all_arr?.enumerated().filter({$1.ayahFilter2.contains(text)}).map({SearchItem.init(text: $1, index: $0)})
        }
        return arr
    }
    
    
}
