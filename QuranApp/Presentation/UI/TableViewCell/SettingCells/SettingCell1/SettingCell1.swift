//
//  SettingCell1.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SettingCell1: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!    
    @IBOutlet weak var vuContain: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vuContain.bor(radius: 12, color: .clear)
        vuContain.shadow()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
