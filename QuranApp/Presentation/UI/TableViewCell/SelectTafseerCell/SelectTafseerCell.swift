//
//  DownloadCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/16/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SelectTafseerCell: UITableViewCell {

    @IBOutlet weak var lblTafseerName: UILabel!
    @IBOutlet weak var vuDownload: UIView!
    @IBOutlet weak var imgDownload: UIImageView!
    
    
    
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
    
    var tafseer: CTafseerModel? {
        
        didSet {
            let name = (AppFactory.isArabic == true ? tafseer?.name_ar : tafseer?.name_en) ?? ""
            self.lblTafseerName.text = name
            self.vuDownload.alpha = tafseer?.downloaded == true ? 0 : 1            
        }
        
    }
    
}
