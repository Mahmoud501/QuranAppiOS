//
//  SelectReciterPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation


class SelectReciterPresenter: SelectReciterDataSource {
    
    var current_type: Int16?
    var current_reciter: String?
    var reciters: [CReciter]?
    private var all_reciters: [CReciter]?
    private var setting: CSetting?
    private var reciterRepo: CoreDataRepository<CReciter>?
    private var settingRepo: CoreDataRepository<CSetting>?
    
    private var allLocalReciter: [CReciter]?
    
    init() {
        self.reciterRepo = CoreDataRepository<CReciter>.init()
        self.settingRepo = CoreDataRepository<CSetting>.init()
        self.setting = self.settingRepo?.getAll()?.first
        self.current_type = self.setting?.reciter_type
        self.current_reciter = self.setting?.current_reciter
    }
    
    
}

extension SelectReciterPresenter: SelectReciterDelegate {
    
    func filter(type: Int, Search: String,finish: ()->()) {
        if type == 0 {
            if Search == "" {
                reciters = all_reciters
            }else {
                reciters = all_reciters?.filter({($0.name_ar?.contains(Search) ?? false) || ($0.name_en?.lowercased().contains(Search.lowercased()) ?? false)})
            }
        }else if type == 1 {//murttal
            reciters =  all_reciters?.filter({ ($0.type ) == ReciterType.Murattal.rawValue})
            if Search != "" {
                reciters = reciters?.filter({($0.name_ar?.lowercased().contains(Search.lowercased()) ?? false) || ($0.name_en?.lowercased().contains(Search.lowercased()) ?? false)})
            }
        }else if type == 2 {//mujawwd
            reciters =  all_reciters?.filter({ ($0.type ) == ReciterType.Mujawad.rawValue})
            if Search != "" {
                reciters = reciters?.filter({($0.name_ar?.lowercased().contains(Search.lowercased()) ?? false) || ($0.name_en?.lowercased().contains(Search.lowercased()) ?? false)})
            }
        }else if type == 3 {//mujawwd
            reciters =  all_reciters?.filter({ ($0.type ) == ReciterType.Muallim.rawValue})
            if Search != "" {
                reciters = reciters?.filter({($0.name_ar?.lowercased().contains(Search.lowercased()) ?? false) || ($0.name_en?.lowercased().contains(Search.lowercased()) ?? false)})
            }
        }else if type == 4 {//mujawwd
            reciters =  all_reciters?.filter({ ($0.type ) == ReciterType.Translate.rawValue})
            if Search != "" {
                reciters = reciters?.filter({($0.name_ar?.lowercased().contains(Search.lowercased()) ?? false) || ($0.name_en?.lowercased().contains(Search.lowercased()) ?? false)})
            }
        }
        finish()
    }
    
    func getReciters(finish: ()->()) {
        all_reciters = reciterRepo?.getAll()?.sorted(by: {(Int($0.id ?? "0") ?? 0) < (Int($1.id ?? "0") ?? 0)})
        reciters = all_reciters
        finish()
    }
    
    func saveSelectedReciter(reciter: CReciter) {
        self.setting?.current_reciter = reciter.id
        self.setting?.reciter_type = reciter.type
        self.current_reciter = reciter.id
        self.current_type = reciter.type
        self.settingRepo?.register(value: setting!)
    }
    
    func getName() -> String? {    
        return UserModel.current?.name
    }
    
    func getIndex() -> Int? {
        let current = AppFactory.currentReciter
        var index = 0
        for item in reciters ?? []{
            if current?.type == item.type && current?.id == item.id {
                print(index)
                return index
            }
            index += 1
        }
        print(index)
        return nil
    }
    
}
