//
//  AboutCell1.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class AboutCell1: UITableViewCell {

    @IBOutlet weak var lblAbout: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
        
    var textt: String? {
        didSet {
            self.lblAbout.text = textt
        }
    }
}

