//
//  TafseerCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/17/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class TafseerCell: UITableViewCell {

    @IBOutlet weak var lblAyaDesc: UILabel!
    @IBOutlet weak var lblTafseer: UILabel!    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var ayah: CAyatModel? {
        didSet {
            self.lblAyaDesc.text = ayah?.desc
            let tafseers = (ayah?.tafseers?.array as? [CTafseerDetailModel])
            let tafseer = tafseers?.first(where: { $0.tafseer_id == AppFactory.tempTafseer?.id})
            self.lblTafseer.text = tafseer?.desc
        }
    }
    
}
