//
//  HomeSliderPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/13/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
 
struct DownloadData {
    
    var isDownloaded: Bool?
    var surha_id: String?
    var status: Int? //0 not downloading, 1 pending , 2 downloading
    var current: Int?
    var total: Int?
    
}



class HomeSliderPresenter {

    var surhas: [CSurha]?
    var isDownloaded: [DownloadData] = Array.init(repeating: DownloadData(), count: 114)
    
    
    var currentReciter: CReciter? {
        get{
            return AppFactory.currentReciter
        }
    }
    
    var numberOFRepeat: String? {
        get {
            return setting?.ayah_repeat.description
        }
    }
    
    var delayTime: String? {
        get {
            return setting?.ayah_delay.description
        }
    }
    
    private var surhaRepo: CoreDataRepository<CSurha>?
    private var settingRepo: CoreDataRepository<CSetting>?
    private var reciterManager: ReciterManger!
    var setting: CSetting?

    init() {
        surhaRepo = CoreDataRepository<CSurha>.init()
        settingRepo = CoreDataRepository<CSetting>.init()
        setting = settingRepo?.getAll()?.first
        reciterManager = ReciterManger()
    }
    
    
    func getSurhas(finish: ()->()) {
        self.surhas = surhaRepo?.getAll()?.sorted(by: { (s1, s2) -> Bool in
            return (Int(s1.id ?? "0") ?? 0) < (Int(s2.id ?? "0") ?? 0)
        })
        let reciter = currentReciter!
        for i in 0 ..< (surhas?.count ?? 0) {
            let isDownload = self.isSurhaDownloaded(reciter: reciter, surha: surhas![i])
            self.isDownloaded[i].isDownloaded = isDownload
        }
        finish()
    }
    
    func refresh(finish: @escaping ()->()) {
        let reciter = currentReciter!
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            for i in 0 ..< (self.surhas?.count ?? 0) {
                let isDownload = self.isSurhaDownloaded(reciter: reciter, surha: self.surhas![i])
                self.isDownloaded[i].isDownloaded = isDownload
            }
            DispatchQueue.main.async {
                finish()
            }
        }
    }
    
    func isSurhaDownloaded(reciter: CReciter,surha: CSurha) -> Bool {
        return reciterManager.isSurhaDownloaded(reciter: reciter, surha: surha)
    }
    
    func downloadSurha(surha: CSurha, for index: Int, reload: @escaping(Int)-> ()) {
        let id = (Int(surha.id!)!) - 1
        reciterManager.downloadAyat(indentifer: "StopDown_\(surha.id ?? "")",reciter: AppFactory.currentReciter!, ayat: surha.ayat?.array as! [CAyatModel], process: { [weak self] (current, total) in
            guard let self = self else { return }
            self.isDownloaded[id].current = current
            self.isDownloaded[id].total = total
            if current < total {
                self.isDownloaded[id].status = 2
            }else {
                self.isDownloaded[id].status = 0
                self.isDownloaded[id].isDownloaded = true
            }
            reload(index)
        }) {[weak self] (error) in
            guard let self = self else { return }
            self.isDownloaded[id].status = 0
            self.isDownloaded[id].isDownloaded = false
            reload(index)
        }
    }
    
    
    func cancelDownload(surha: CSurha) {
        UserDefaultClass.setValue("StopDown_\(surha.id ?? "")", true)
    }
    
    
    
    
    func saveRepeatTime(time: String) {
        setting?.ayah_repeat = Int16(time) ?? 0
        settingRepo?.register(value: setting!)
    }
    
    func saveDelayTime(time: String) {
        setting?.ayah_delay = Int16(time) ?? 0
        settingRepo?.register(value: setting!)
    }
    
    
}
