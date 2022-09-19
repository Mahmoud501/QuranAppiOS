//
//  HomePresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class HomePresenter: HomeDataSource {
    
    var QuranType: String? = "" // 0 or "" -> page , 1 -> surha , 2 -> juzh
    var scrollDirect: String? = "0" // 0 or "" -> middle , 1 -> top , 2 -> none
    var isSingleSelection: Bool? = false
    
    var reciter: CReciter? {
        get {
            AppFactory.currentReciter
        }
    }
    
    var tafseer_id: String? {
        get {
            return AppFactory.currentTafseer?.id
        }
    }
    
    var openAyatOptions: Bool {
        get {
            return (selectedAyat?.count ?? 0) > 0
        }
    }
    
    var mark_id: String? {
        get {
            return setting?.mark_ayah_id
        }
    }
    
    var selectedAyat: Dictionary<String, CAyatModel>?
    
    var pages: [CPage]?
    
    var surhas: [CSurha]?
    
    var juzhs: [CJuzh]?
    
    private var pageRepo: CoreDataRepository<CPage>?
    private var surhaRepo: CoreDataRepository<CSurha>?
    private var juzhRepo: CoreDataRepository<CJuzh>?
    private var settingRepo: CoreDataRepository<CSetting>?
    var setting: CSetting?
    var networkSetting = SettingRepo()
 
    
    init() {
        pageRepo = CoreDataRepository<CPage>.init()
        surhaRepo = CoreDataRepository<CSurha>.init()
        juzhRepo = CoreDataRepository<CJuzh>.init()
        settingRepo = CoreDataRepository<CSetting>.init()
        setting = settingRepo?.getAll()?.first
        self.QuranType = setting?.current_quran_type ?? "0"
        self.scrollDirect = setting?.ayatScrollDirection ?? "0"
        self.selectedAyat = Dictionary<String, CAyatModel>()
        self.isSingleSelection = setting?.isSingleSelection ?? false
    }
    
    
}


extension HomePresenter: HomeBusiness {
    
    @discardableResult
    func getPages(finish: () -> ()) -> [CPage]? {
        self.pages = pageRepo?.getAll()?.sorted(by: { (p1, p2) -> Bool in
            return (Int(p1.id ?? "0") ?? 0) < (Int(p2.id ?? "0") ?? 0)
        })
        finish()
        return pages
    }
    
    @discardableResult
    func getSurhas(finish: () -> ()) -> [CSurha]? {
        self.surhas = surhaRepo?.getAll()?.sorted(by: { (s1, s2) -> Bool in
            return (Int(s1.id ?? "0") ?? 0) < (Int(s2.id ?? "0") ?? 0)
        })
        finish()
        return surhas

    }
    
    @discardableResult
    func getJuzhs(finish: () -> ()) -> [CJuzh]? {
        self.juzhs = juzhRepo?.getAll()?.sorted(by: { (j1, j2) -> Bool in
            return (Int(j1.id ?? "0") ?? 0) < (Int(j2.id ?? "0") ?? 0)
        })
        finish()
        return juzhs
    }
    
    func resetData() {
        self.pages = nil
        self.surhas = nil
        self.juzhs = nil
    }
    
    func getHome(finish: ()->()) {
        resetData()
        if QuranType == "" || QuranType == "0" {
            getPages(finish: finish)
        }else if QuranType == "1" {
            getSurhas(finish: finish)
        }else if QuranType == "2" {
            getJuzhs(finish: finish)
        }
    }
    
 
    func getTitle(section: Int) -> String? {
        if QuranType == "" || QuranType == "0" {
            return AppFactory.isArabic == true ? pages?[section].name_ar : pages?[section].name_en
        }else if QuranType == "1" {
            return AppFactory.isArabic == true ? surhas?[section].name_ar : surhas?[section].name_en
        }else if QuranType == "2" {
            return AppFactory.isArabic == true ? juzhs?[section].name_ar : juzhs?[section].name_en
        }
        return ""
    }
    
    func getSelected(section: Int) -> Bool? {
           if QuranType == "" || QuranType == "0" {
               return pages?[section].isSelected
           }else if QuranType == "1" {
               return surhas?[section].isSelected
           }else if QuranType == "2" {
               return juzhs?[section].isSelected
           }
           return false
    }
       
    
    func getCountSections() -> Int {
        if QuranType == "" || QuranType == "0" {
            return pages?.count ?? 0
        }else if QuranType == "1" {
            return surhas?.count ?? 0
        }else if QuranType == "2" {
            return juzhs?.count ?? 0
        }
        return 0
    }
    
    
    func getSection(section: Int) -> Any? {
        if QuranType == "" || QuranType == "0" {
            return pages?[section]
        }else if QuranType == "1" {
            return surhas?[section]
        }else if QuranType == "2" {
            return juzhs?[section]
        }
        return 0
    }

    
    func getCountRows(section: Int) -> Int {        
        if QuranType == "" || QuranType == "0" {
            return pages?[section].ayat?.count ?? 0
        }else if QuranType == "1" {
            return surhas?[section].ayat?.count ?? 0
        }else if QuranType == "2" {
            return juzhs?[section].ayat?.count ?? 0
        }
        return 0
    }
    
    func getAyah(section: Int,row: Int) -> CAyatModel? {
        if QuranType == "" || QuranType == "0" {
            if (pages?.count ?? 0) <= section {return nil}
            let ayat = pages?[section].ayat?.array as? [CAyatModel]
            if (ayat?.count ?? 0) <= row { return nil}
            return ayat?[row]
        }else if QuranType == "1" {
            if (surhas?.count ?? 0) <= section {return nil}
            let ayat = surhas?[section].ayat?.array  as? [CAyatModel]
            if (ayat?.count ?? 0) <= row { return nil}
            return ayat?[row]
        }else if QuranType == "2" {
            if (juzhs?.count ?? 0) <= section {return nil}
            let ayat = juzhs?[section].ayat?.array  as? [CAyatModel]
            if (ayat?.count ?? 0) <= row { return nil}
            return ayat?[row]
        }
        return nil
    }
    
    
    func changeQuranType(to: String) {
        self.QuranType = to
        self.setting?.current_quran_type = to
        self.settingRepo?.register(value: setting!)
    }
        
    
    func didSelectAyah(ayah: CAyatModel?) {
        if self.isSingleSelection == true {
            if ayah?.isSelected == true {
                if ayah?.surha?.isSelected == true || ayah?.page?.isSelected == true || ayah?.juzh?.isSelected == true {
                    
                }else {
                    self.clearSelection()
                    return
                }
            }
            self.clearSelection()
        }
        if ayah?.isSelected == true {
            ayah?.isSelected = false
            selectedAyat?.removeValue(forKey: ayah?.id ?? "")
        }else {
            selectedAyat?[ayah?.id ?? ""] = ayah
            ayah?.isSelected = true
        }
        var flag = true
        if (QuranType ?? "0") == "0" {
            for item in ayah?.page?.ayat?.array as? [CAyatModel] ?? [] {
                if item.isSelected == false {
                    flag = false
                    break
                }
            }
            ayah?.page?.isSelected = flag
        }else if QuranType == "1" {
            for item in ayah?.surha?.ayat?.array as? [CAyatModel] ?? [] {
                if item.isSelected == false {
                    flag = false
                    break
                }
            }
            ayah?.surha?.isSelected = flag
        }else {
            for item in ayah?.juzh?.ayat?.array as? [CAyatModel] ?? [] {
                if item.isSelected == false {
                    flag = false
                    break
                }
            }
            ayah?.juzh?.isSelected = flag
        }
    }
    
    func didSelectSection(package: Any?) {
       
        if (QuranType ?? "0") == "0" {
            let obj = package as? CPage
            if self.isSingleSelection == true {
                if obj?.isSelected == true {
                    self.clearSelection()
                    return
                }else {
                    self.clearSelection()
                }
            }
            obj?.isSelected = !(obj?.isSelected ?? false)
            for item in obj?.ayat?.array as? [CAyatModel] ?? [] {
                item.isSelected = obj?.isSelected ?? false
                if obj?.isSelected == true {
                    selectedAyat?[item.id ?? ""] = item
                }else {
                    selectedAyat?.removeValue(forKey: item.id ?? "")
                }
            }
        }else if (QuranType ?? "0") == "1" {
            let obj = package as? CSurha
            if self.isSingleSelection == true {
                if obj?.isSelected == true {
                    self.clearSelection()
                    return
                }else {
                    self.clearSelection()
                }
            }
            obj?.isSelected = !(obj?.isSelected ?? false)
            for item in obj?.ayat?.array as? [CAyatModel] ?? [] {
                item.isSelected = obj?.isSelected ?? false
                if obj?.isSelected == true {
                    selectedAyat?[item.id ?? ""] = item
                }else {
                    selectedAyat?.removeValue(forKey: item.id ?? "")
                }
            }
        }else {
            let obj = package as? CJuzh
            if self.isSingleSelection == true {
                if obj?.isSelected == true {
                    self.clearSelection()
                    return
                }else {
                    self.clearSelection()
                }
            }
            obj?.isSelected = !(obj?.isSelected ?? false)
            for item in obj?.ayat?.array as? [CAyatModel] ?? [] {
                item.isSelected = obj?.isSelected ?? false
                if obj?.isSelected == true {
                    selectedAyat?[item.id ?? ""] = item
                }else {
                    selectedAyat?.removeValue(forKey: item.id ?? "")
                }
            }
        }
    }
    
    func getIndexPathOf(ayah: CAyatModel?)-> (Int?, Int?){
        if let ayah = ayah {
            if (QuranType ?? "0") == "0" {
                let section = (Int(ayah.page?.id ?? "0") ?? 0) - 1
                let row = (self.pages?[section].ayat?.array as? [CAyatModel])?.firstIndex(of: ayah)
                return (section, row)
            }else if (QuranType ?? "0") == "1" {
                let section = (Int(ayah.surha?.id ?? "0") ?? 0) - 1
                let row = (self.surhas?[section].ayat?.array as? [CAyatModel])?.firstIndex(of: ayah)
                return (section, row)
            }else {
                let section = (Int(ayah.juzh?.id ?? "0") ?? 0) - 1
                let row = (self.juzhs?[section].ayat?.array as? [CAyatModel])?.firstIndex(of: ayah)
                return (section, row)
            }
        }
        return (nil, nil)
    }
    
    
    
    func clearSelection() {
        if let ayat = self.selectedAyat {
            for item in ayat {
                item.value.surha?.isSelected = false
                item.value.page?.isSelected = false
                item.value.juzh?.isSelected = false
                item.value.isSelected = false
            }
            self.selectedAyat = nil
            self.selectedAyat = Dictionary<String, CAyatModel>()
        }
    }
    
    func saveMark(ayah: CAyatModel?) {
        self.setting?.mark_ayah_id = ayah?.id
        settingRepo?.register(value: setting!)
    }
    
    
    func getAyahId(id: String?) -> CAyatModel? {
        if let mark_id = id {
            let ayahRepo = CoreDataRepository<CAyatModel>.init()
            if let ayah = ayahRepo.query(with: "id == \"\(mark_id)\"")?.first {
                return ayah
            }else{
                print("empty with id = \(id ?? "")")
            }
        }
        return nil
    }

    
    func getMarkAyah() -> CAyatModel? {
        return getAyahId(id: self.setting?.mark_ayah_id)
    }
    
    
    func getFilePDF() -> String? {
        return networkSetting.getExistPath()
    }
    
    func download(finish:(()->())?) {
        networkSetting.downloadFile(finish: finish)
    }
    
}
