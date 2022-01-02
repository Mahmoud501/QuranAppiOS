//
//  DownloadCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/16/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import DownloadButton

class DownloadCell: UITableViewCell {

    @IBOutlet weak var vuDownload: PKDownloadButton!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var lblSurhaName: UILabel!
    @IBOutlet weak var lblSurhaNum: UILabel!
    @IBOutlet weak var lblAyatCount: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBAction func downloadClicked(_ sender: Any) {
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vuDownload.setCirleCornerRadius()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var surha: CSurha? {
        didSet {
            self.lblSurhaNum.text = "[" + "Surha no.".localized + " " +  (surha?.id ?? "0") + "]"
            self.lblAyatCount.text = "Number of Ayat".localized + " " + (surha?.number_ayat.description ?? "0")
            self.lblSurhaName.text = AppFactory.isArabic == true ? surha?.name_ar : surha?.name_en
            vuDownload.setupButton()
        }
    }
    
    var download: DownloadData? {
        
        didSet {
            if (download?.isDownloaded ?? false) == true {
                self.vuDownload.alpha = 0
            }else {
                if (download?.status ?? 0) == 0 {
                    imgDown.alpha = 1
                    vuDownload.state = .startDownload
                    vuDownload.stopDownloadButton.progress = 0
                }
                else if (download?.status ?? 1) == 1 {
                    vuDownload.state = .pending
                    imgDown.alpha = 0
                }else if (download?.status ?? 1) == 2 {
                    
                    vuDownload.state = .downloading
                    imgDown.alpha = 0
                    let precent = (CGFloat((download?.current ?? 1)) / CGFloat((download?.total ?? 1)))
                    vuDownload.stopDownloadButton.progress = precent
                }

                self.vuDownload.alpha = 1
            }
        }
    }
    
}
