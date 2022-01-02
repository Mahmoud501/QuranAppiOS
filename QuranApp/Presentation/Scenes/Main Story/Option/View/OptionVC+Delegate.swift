//
//  OptionVC+Delegate.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/11/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit


extension OptionVC: RegisterView {
    
    
    func registerSuccess() {
        next()
    }
    
    func registerFail(error: String) {
        AlertClass2.showMessageError(title: "SomeThing Wrong".localized, message: error, infoTap: nil)
    }
    
    func registerFailNetwork() {
        AlertClass2.ShowErrorStatusBar(vc: nil, message: "net.message".localized)
    }
    
    func registerFinish() {
        btnSave.stopAnimation(animationStyle: .normal, revertAfterDelay: 0) {
            self.btnSave.setNeedsDisplay()
            self.btnSave.layoutIfNeeded()
        }
        
    }
    
    
    
}
