//
//  FAQCell.swift
//  Majdona
//
//  Created by MAJED A  ALGARNI on 5/1/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import UIKit

class FAQCell: UITableViewCell {


    @IBOutlet weak var vuContain: UIView!
    //Path 10815 = down
    //Path 19062 = up
    @IBOutlet weak var ImgArrow: UIImageView!    
    @IBOutlet weak var lblQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vuContain.bor(radius: 15, color: .clear)
        vuContain.shadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
