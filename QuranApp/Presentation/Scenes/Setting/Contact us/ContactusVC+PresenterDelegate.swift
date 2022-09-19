//
//  ContactusVC+PresenterDelegate.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 11/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit
import ZVProgressHUD

extension ContactusVC: ContactusView {
    
    func finish() {
        ZVProgressHUD.dismiss()
    }
    
    func success(str: String) {
        AlertClass2.ShowSuccessMessage(vc: nil, message: str, title: "Contact us".localized, interact: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func error(str: String) {
        AlertClass2.ShowErrorStatusBar(vc: nil, message: str)
    }
    
}
