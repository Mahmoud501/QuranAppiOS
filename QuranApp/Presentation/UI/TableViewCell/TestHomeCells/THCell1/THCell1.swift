//
//  THCell1.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import DownloadButton

class THCell1: UITableViewCell {

    
    @IBOutlet weak var lblSurhaName: UILabel!
    @IBOutlet weak var lblSurhaNum: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var vuDownload: PKDownloadButton!
    @IBOutlet weak var btnResult: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        if AppFactory.isIPad == true {
         vuDownload.setupButton( radiusPrecent: 0.8)
        }else {
            vuDownload.setupButton( radiusPrecent: 0.4)
        }
        vuDownload.setCirleCornerRadius()
        self.vuDownload.state = .downloading
        self.vuDownload.stopDownloadButton.stopButtonWidth  = 0
        self.lblDate.text = " "
    }
    

    var item: CSurha? {
        didSet {
            let total_count = Int(item?.total_memory ?? "0") ?? 0
            let precent: Double = Double(total_count) / Double(item?.number_ayat ?? 1)
            let Intprecent = Int(precent * 100)
            let final = Double(Double(Intprecent) / Double(100))
            self.vuDownload.stopDownloadButton.progress = CGFloat(final)
            let str = String(format: "%.1f", (final * 100))
            self.btnResult.setTitle(str.description, for: .normal)
            self.lblSurhaNum.text = "[ " + (item?.number_ayat.description ?? "0") + " ]"
            self.lblSurhaName.text = AppFactory.isArabic == true ? item?.name_ar : item?.name_en
        }
    }
    
}
