//
//  SelectReciterHeaderCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SelectReciterHeaderCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var name: String? {
        didSet {
            self.lblName.text = "Welcome".localized + " " + (name ?? "")
        }
    }
    
}
