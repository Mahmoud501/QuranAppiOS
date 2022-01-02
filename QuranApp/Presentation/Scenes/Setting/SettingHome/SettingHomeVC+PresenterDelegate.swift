//
//  SettingHomeVC+PresenterDelegate.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit
import ZVProgressHUD

extension SettingHomeVC: SettingView {
    
    func finish() {        
    }
    
    func success() {
        self.TVSetting.reloadData()
    }
    
    func error(str: String) {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(reload))
        AlertClass2.ShowActionErrorStatusBar(vc: self, message: str, infoTap: tap)
    }
    
    @objc func reload() {
        AlertClass2.hideMessage()
        presenter?.getSetting()
    }
}
