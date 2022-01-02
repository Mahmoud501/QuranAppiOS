//
//  QuranSettingPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/13/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation



class QuranSettingPresenter {

    var quranWithMarks: Bool = true
    var scrollDirect: String? = "0"
    var quranFontType: String? = "0" // 0 cairo , 1 uthman , 2 normal
    var quranFontSize: String? = "0"
    var tafseerFontSize: String? = "0" //0 normal , 1 large , 2 very large
    var isSingleSelection: Bool? = false
    
    private var settingRepo: CoreDataRepository<CSetting>?
    private var setting: CSetting?
    
    init() {
        settingRepo = CoreDataRepository<CSetting>.init()
        setting = settingRepo?.getAll()?.first
        quranWithMarks = setting?.quranWithMark ?? true
        quranFontType = setting?.font_type ?? "0"
        quranFontSize = setting?.quran_font_size ?? "0"
        tafseerFontSize = setting?.tafseer_font_size ?? "0"
        self.isSingleSelection = setting?.isSingleSelection ?? false
        scrollDirect = setting?.ayatScrollDirection ?? "0"
    }
    
    func saveSetting() -> CSetting? {
        setting?.quranWithMark = quranWithMarks
        setting?.font_type = quranFontType
        setting?.quran_font_size = quranFontSize
        setting?.tafseer_font_size = tafseerFontSize
        setting?.ayatScrollDirection = scrollDirect
        setting?.isSingleSelection = isSingleSelection ?? false
        settingRepo?.register(value: setting!)
        return setting
    }
    
}
