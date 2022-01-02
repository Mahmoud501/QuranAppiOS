//
//  SettingHomePresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class SettingHomePresenter {
    
    var facebook: String?
    var twitter: String?
    var lastVersion: Int?
    var currentVersion = 1
    
    private var settingRepo: SettingRepo?
    private weak var settingView: SettingView?
    
    
    init(settingView: SettingView?) {
        settingRepo = SettingRepo()
        self.settingView = settingView
        
    }
    
    
    func getSetting() {
    
        settingRepo?.getSetting(myResponse: { (model, error) in
            self.settingView?.finish()
            if error == nil {
                self.facebook = model?.faceook
                self.twitter = model?.twitter
                self.lastVersion = model?.last_version_ios
                self.settingView?.success()
            }else {
                switch error {
                case .noInternetConnection:
                    self.settingView?.error(str: "Network Error".localized)
                    break
                default:
                    self.settingView?.error(str: error?.errorDescription ?? "")
                }
            }
        })
        
    }
    
    
    
    
}
