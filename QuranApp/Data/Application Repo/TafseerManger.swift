//
//  TafseerManger.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/6/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class TafseerManger {
        
    var fileManager = MyFileManager()
    
  
    
    func installTafseerType(id: String, name_ar: String, name_en: String, link: String, isDownloaded: Bool? = nil) -> CTafseerModel {
        let repo = CoreDataRepository<CTafseerModel>.init()
        let f1 = CTafseerModel.init(context: repo.context!)
        f1.id = id
        f1.idInt = Int16(id)!
        f1.name_ar = name_ar
        f1.name_en = name_en
        f1.link = link
        f1.downloaded = isDownloaded ?? false
        repo.register(value: f1)
        return f1
    }
    
    func installTafseerDetails(from: CTafseerModel ,finish: ((CTafseerModel?)->())? = nil) {
        
        var contents: String? = try? String.init(contentsOfFile: from.link ?? "", encoding: .utf8)
        if contents == nil {
            guard let url = URL(string: from.link ?? "") else {
                finish?(nil)
                return
            }
            contents =  try? String.init(contentsOf: url, encoding: .utf8)
            if contents == nil {
                finish?(nil)
                return
            }
        }
        let tafseerArray = contents?.split(separator: "\n") ?? []
        let ayahRepo = CoreDataRepository<CAyatModel>.init()
        var ayat = (ayahRepo.getAll() ?? [])
        ayat.sort(by: { (c1, c2) -> Bool in
            return (Int(c1.id ?? "0") ?? 0) < (Int(c2.id ?? "0") ?? 0)
        })
        for i  in 0 ..< (tafseerArray.count ) {
            if i == ayat.count { break }
            let repo = CoreDataRepository<CTafseerDetailModel>.init()
            let tafseerDetail = CTafseerDetailModel.init(context: repo.context!)
            tafseerDetail.id = (i + 1).description
            tafseerDetail.idInt = Int16(i + 1)
            tafseerDetail.tafseer_id = from.id
            tafseerDetail.tafseer = from
            tafseerDetail.ayah_id = (i + 1).description
            tafseerDetail.desc = tafseerArray[i].description
            tafseerDetail.ayah = ayat[i]
            ayat[i].addToTafseers(tafseerDetail)
            ayahRepo.register(value: ayat[i])
            repo.register(value: tafseerDetail)
            //print(i + 1)
        }
        let tafseerRepo = CoreDataRepository<CTafseerModel>.init()
        from.downloaded = true
        tafseerRepo.register(value: from)
        finish?(from)
    }
    

    func initInstallation(finish: (()->())? = nil) {
        _ = self.installTafseerType(id: TafseerName.None.rawValue, name_ar: "إخفاء التفسير", name_en: "Hide Tafseer",link: "", isDownloaded: true)

        let link_moyaseer = fileManager.getPathOf(fileName: "ar.muyassar", fileType: "txt") ?? ""
        let moyaseer = self.installTafseerType(id: TafseerName.Moyaseer.rawValue, name_ar: "الميسر", name_en: "",link: link_moyaseer)
        
        let link_glalen = fileManager.getPathOf(fileName: "ar.jalalayn", fileType: "txt") ?? ""
        let glalen = self.installTafseerType(id: TafseerName.Glalin.rawValue, name_ar: "الجلالين", name_en: "",link: link_glalen)
        
        let link_english = "http://tanzil.net/trans/en.sahih"
        _ = self.installTafseerType(id: TafseerName.English_Saheeh_International.rawValue, name_ar: "English - Saheeh International", name_en: "",link: link_english)

        let link_german = "http://tanzil.net/trans/de.aburida"
        _ = self.installTafseerType(id: TafseerName.German_Abu_Rida_Muhammad.rawValue, name_ar: "German - Abu Rida Muhammad", name_en: "",link: link_german)
        
        
        let link_franch = "http://tanzil.net/trans/fr.hamidullah"
        _ = self.installTafseerType(id: TafseerName.French_Muhammad_Hamidullah.rawValue, name_ar: "French - Muhammad Hamidullah", name_en: "",link: link_franch)
        
        let link_russian = "http://tanzil.net/trans/ru.muntahab"
        _ = self.installTafseerType(id: TafseerName.Russian_MinistryEgypt.rawValue, name_ar: "Russian - Ministry of Awqaf, Egypt", name_en: "",link: link_russian)

        let link_hindi = "http://tanzil.net/trans/hi.farooq"
        _ = self.installTafseerType(id: TafseerName.Hindi_Muhammad_Farooq.rawValue, name_ar: "Hindi - Muhammad Farooq Khan and Muhammad Ahmed", name_en: "",link: link_hindi)

        let link_indonesian = "http://tanzil.net/trans/id.indonesian"
        _ = self.installTafseerType(id: TafseerName.Indonesian_Indonesian_Ministry.rawValue, name_ar: "Indonesian - Indonesian Ministry of Religious Affairs", name_en: "",link: link_indonesian)

        
        let link_italian = "http://tanzil.net/trans/it.piccardo"
        _ = self.installTafseerType(id: TafseerName.Italian_Hamza_Roberto.rawValue, name_ar: "Italian - Hamza Roberto Piccardo", name_en: "",link: link_italian)

        let link_romanian = "http://tanzil.net/trans/ro.grigore"
        _ = self.installTafseerType(id: TafseerName.Romanian_George.rawValue, name_ar: "Romanian - George Grigore", name_en: "",link: link_romanian)

        let link_spain = "http://tanzil.net/trans/es.bornez"
        _ = self.installTafseerType(id: TafseerName.Spanish_Raúl_González.rawValue, name_ar: "Spanish - Raúl González Bórnez", name_en: "",link: link_spain)

        let link_swedish = "http://tanzil.net/trans/sv.bernstrom"
        _ = self.installTafseerType(id: TafseerName.Swedish_Knut.rawValue, name_ar: "Swedish - Knut Bernström", name_en: "",link: link_swedish)

        
        let link_turkey = "http://tanzil.net/trans/tr.golpinarli"
        _ = self.installTafseerType(id: TafseerName.Turkish_Abdulbaki.rawValue, name_ar: "Turkish - Abdulbaki Golpinarli", name_en: "",link: link_turkey)

        
        let link_china = "http://tanzil.net/trans/zh.jian"
        _ = self.installTafseerType(id: TafseerName.Chinese_Ma.rawValue, name_ar: "Chinese - Ma Jian", name_en: "",link: link_china)

        let link_jaban = "http://tanzil.net/trans/ja.japanese"
        _ = self.installTafseerType(id: TafseerName.Japanese_Unknown.rawValue, name_ar: "Japanese - Unknown", name_en: "",link: link_jaban)

        let link_Korean = "http://tanzil.net/trans/ko.korean"
        _ = self.installTafseerType(id: TafseerName.Korean_Unknown.rawValue, name_ar: "Korean - Unknown", name_en: "",link: link_Korean)
        
        
        let link_portuguese = "http://tanzil.net/trans/pt.elhayek"
        _ = self.installTafseerType(id: TafseerName.Portuguese_Samir.rawValue, name_ar: "Portuguese - Samir El-Hayek", name_en: "",link: link_portuguese)
        
        
        self.installTafseerDetails(from: moyaseer)
        self.installTafseerDetails(from: glalen)
        finish?()

    }
    
}
