//
//  TestHomePresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class TestHomePresenter {
                
    var surhas: [CSurha]?
    var filter_surhas: [CSurha] = []
    var total_count = 0
    private var surhaRepo: CoreDataRepository<CSurha>?

    
    init() {
        surhaRepo = CoreDataRepository<CSurha>.init()
    }
    
    @discardableResult
    private func getSurhas(finish: () -> ()) -> [CSurha]? {
        self.surhas = surhaRepo?.getAll()?.sorted(by: { (s1, s2) -> Bool in
            return (Int(s1.id ?? "0") ?? 0) < (Int(s2.id ?? "0") ?? 0)
        })
        finish()
        return surhas
    }
    
    
    func filerSurhas(finish: () -> ()) {
        filter_surhas = []
        total_count = 0
        getSurhas {[weak self] in
            for item in self?.surhas ?? [] {
                var count = 0
                for ayah in item.ayat?.array as? [CAyatModel] ?? [] {
                    if ayah.isMemorized == true {
                        count += 1
                    }
                }
                total_count += count
                if count > 0 {
                    item.total_memory = count.description
                    filter_surhas.append(item)
                }else {
                    item.total_memory = ""
                }
            }
            finish()
        }
    }
    
    
}
