//
//  TafseerPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class SelectTafseerPresenter: SelectTafseerDataSource {
    
    // 1 -> Current Tafseer for home & App
    // 2 temp tafseer for popup menu when select ayat
    var type: Int = 1
    ////////////////////////////////////////////////
    var selected_id: String?
    var tafseers: [CTafseerModel]?
    private var setting: CSetting?
    private var tafseerManger: TafseerManger?
    private var tafseerRepo: CoreDataRepository<CTafseerModel>?
    private var settingRepo: CoreDataRepository<CSetting>?
    private weak var downloadView: TafseerDownloadView?

    init(downloadView: TafseerDownloadView?, type: Int) {
        self.type = type
        self.tafseerManger = TafseerManger()
        self.tafseerRepo = CoreDataRepository<CTafseerModel>.init()
        self.settingRepo = CoreDataRepository<CSetting>.init()
        self.setting = self.settingRepo?.getAll()?.first
        if type == 1 {
            self.selected_id = setting?.current_tafseer ?? "0"
        }else {
            self.selected_id = setting?.temp_tafseer ?? "1"
        }
        self.downloadView = downloadView
    }
    
}


extension SelectTafseerPresenter: SelectTafseerBusiness {
    
    func getTafseers(finish: () -> ()) {
        tafseers = tafseerRepo?.getAll()?.sorted(by: {(Int($0.id ?? "0") ?? 0) < (Int($1.id ?? "0") ?? 0)})
        finish()

    }
    
    func saveSelectedTafseer(tafseer: CTafseerModel) {
        if type == 1 {
            self.setting?.current_tafseer = tafseer.id
        }else {
            self.setting?.temp_tafseer = tafseer.id
        }
        self.selected_id = tafseer.id
        self.settingRepo?.register(value: setting!)
    }
    
    func downloadTafseer(tafseer: CTafseerModel?) {
        guard let tafseer = tafseer else {
            self.downloadView?.finish()
            self.downloadView?.failure()
            return
        }
        tafseerManger?.installTafseerDetails(from: tafseer, finish: { [weak self](downloadTafseer) in
            guard let self = self else { return }
            self.downloadView?.finish()
            if downloadTafseer == nil {
                self.downloadView?.failure()
            }else {
                tafseer.downloaded = true
                self.downloadView?.success()
            }
            
        })
    }
    
    
    
}
