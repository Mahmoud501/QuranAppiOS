//
//  AboutusPresenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation

class AboutusPresenter {
    
    var aboutus: String?
    var team: [TeamMemberModel]?
    
    private var settingRepo: SettingRepo?
    private weak var aboutView: AboutusView?
    
    
    init(aboutView: AboutusView?) {
        settingRepo = SettingRepo()
        self.aboutView = aboutView
        
    }
    
    
    func getAbout() {
    
        settingRepo?.getAbout(myResponse: { (model, error) in
            self.aboutView?.finish()
            if error == nil {
                self.aboutus = model?.aboutus
                self.team = model?.team?.reversed()
                self.aboutView?.success()
            }else {
                switch error {
                case .noInternetConnection:
                    self.aboutView?.error(str: "Network Error".localized)
                    break
                default:
                    self.aboutView?.error(str: error?.errorDescription ?? "")
                }
            }
        })
        
    }
    
    
    
    
}
