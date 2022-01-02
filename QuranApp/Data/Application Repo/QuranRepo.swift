//
//  QuranRepo.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/4/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class QuranRepo {
    
    private var surhaManger: SurhaManger = SurhaManger()
    private var pageManger: PageManger = PageManger()
    private var juzhManger: JuzhManger = JuzhManger()
    private var tafseerManger: TafseerManger = TafseerManger()
    private var reciterManger: ReciterManger = ReciterManger()

    private var fileManager: MyFileManager = MyFileManager()
    
    
    private func installAyat() -> [CAyatModel] {
        let quranText = fileManager.readFile(fileName: "quran-file", fileType: "txt")
        let quranCleanText = fileManager.readFile(fileName: "quran-simple-clean", fileType: "txt")
        let ayatText = quranText?.split(separator: "\r\n")
        let ayatCleanText = quranCleanText?.split(separator: "\r\n")
        var ayatData = [CAyatModel]()
        for i  in 0 ..< (ayatText?.count ?? 0) {
            let repo = CoreDataRepository<CAyatModel>.init()
            let ayah = CAyatModel.init(context: repo.context!)
            ayah.id = (i + 1).description
            ayah.desc = ayatText?[i].description
            ayah.simple_desc = ayatCleanText?[i].description
            ayatData.append(ayah)
        }
        return ayatData
    }
    
    
    private func installquranByCategory(finish: (()->())? = nil) {
        let ayat = installAyat()
        
        let pages = pageManger.installPage()
        
        for item in pages {
            for i in item.start ... ((item.number_ayat + item.start ) - 1) {
                let ayah = ayat[Int(i) - 1]
                ayah.page = item
                item.addToAyat(ayah)
            }
            
        }

        let surha = surhaManger.installSurha()
        for item in surha {
            var index = 1
            for i in item.start ... ((item.number_ayat + item.start ) - 1) {
                let ayah = ayat[Int(i) - 1]
                ayah.surha = item
                ayah.sort = Int32(index)
                item.addToAyat(ayah)
                index = index + 1
            }
        }

        
        let juzhs = juzhManger.installJuzh()
        for item in juzhs {
            for i in item.start ... (item.number_ayat + item.start ) {
                if i >= 6237 { continue }
                let ayah = ayat[Int(i) - 1]
                ayah.juzh = item
                item.addToAyat(ayah)
            }
        }
        CoreDataRepository.save()
        finish?()
    }
    
    func installQuran(finish: (()->())? = nil, process: ((Double,String)->())? = nil) {
        
        process?(0,"Install Quran".localized + "...")        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.installquranByCategory {
                process?(0.4,"Install Tafseers".localized + "...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.tafseerManger.initInstallation {
                        process?(0.6, "Install Reciters".localized + "...")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            self.reciterManger.installReciters {
                                process?(0.8,"Setup Setting".localized + "...")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                    //install setting
                                    let settingRepo = CoreDataRepository<CSetting>.init()
                                    let setting = CSetting.init(context: settingRepo.context!)
                                    setting.total_test = 0
                                    setting.ayah_delay = 0
                                    setting.font_type = "3"// look at setting
                                    setting.quran_font_size = "2" //0 normal , 1 big , 2very big
                                    setting.tafseer_font_size = "0"
                                    setting.temp_tafseer = "1"
                                    setting.ayatScrollDirection = "1" // 0 middle , 1 top , 2 -> none
                                    setting.ayah_repeat = 0
                                    setting.current_tafseer = TafseerName.None.rawValue
                                    setting.current_quran_type = "0" //page navigation
                                    settingRepo.register(value: setting)
                                    process?(1,"Finish Installation".localized)
                                    finish?()
                                }
                            }
                        }

                    }
                }

            }
        }        
    }
    
    
    
    
    
}
