//
//  AppFactory.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

class AppFactory {
    
    
    static var lang: String? {
        get { (UserDefaults.standard.object(forKey: "loclz") as? String) }
    }
    
    static var isArabic : Bool {
        return (UserDefaults.standard.object(forKey: "loclz") as? String) == "ar"
    }
    
    static var isIPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var homeVC: HomeVC?
    
    static var currentReciter: CReciter? {
        
        get {
            
            let repo = CoreDataRepository<CSetting>.init()
            let setting = repo.getAll()?.first
            let current_reciter_id = setting?.current_reciter ?? "0"
            let type = setting?.reciter_type ?? 0
            let repoReciter = CoreDataRepository<CReciter>.init()
            return repoReciter.query(with: "id == \(current_reciter_id) && type == \(type)")?.first
        }
        
    }
    
    
    static var currentTafseer: CTafseerModel? {
        get {            
            let repo = CoreDataRepository<CSetting>.init()
            let setting = repo.getAll()?.first
            let current_tafseer_id = setting?.current_tafseer ?? "0"
            let repoReciter = CoreDataRepository<CTafseerModel>.init()
            return repoReciter.query(with: "id == \(current_tafseer_id)")?.first
        }
    }
    
    static var tempTafseer: CTafseerModel? {
        get {
            let repo = CoreDataRepository<CSetting>.init()
            let setting = repo.getAll()?.first
            let current_tafseer_id = setting?.temp_tafseer ?? "1"
            let repoReciter = CoreDataRepository<CTafseerModel>.init()
            return repoReciter.query(with: "id == \(current_tafseer_id)")?.first
        }
    }
    
}
