//
//  AboutusVC+PresenterDelegate.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit
import ZVProgressHUD

extension AboutusVC: AboutusView {
    
    func finish() {
        ZVProgressHUD.dismiss()
    }
    
    func success() {
        self.TVAbout.reloadData()
    }
    
    func error(str: String) {
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(reload))
        AlertClass2.ShowActionErrorStatusBar(vc: self, message: str, infoTap: tap)
    }
    
    @objc func reload() {
        AlertClass2.hideMessage()
        ZVProgressHUD.show()
        presenter?.getAbout()
    }
}
