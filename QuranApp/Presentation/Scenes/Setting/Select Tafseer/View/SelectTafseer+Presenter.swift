//
//  SelectTafseer+Presenter.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/12/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import ZVProgressHUD

extension SelectTafseerVC: TafseerDownloadView {
    
    func finish() {
        ZVProgressHUD.dismiss()
    }
    
    func success() {
        self.TVTafseer.reloadData()
    }
    
    func failure() {
        AlertClass2.ShowErrorStatusBar(vc: self, message: "net.message".localized)
    }
        
}
