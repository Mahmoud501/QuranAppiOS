//
//  SettingCell2.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SettingCell2: UITableViewCell {

    @IBOutlet weak var lblVersion: UILabel!
    
    @IBAction func faceClicked(_ sender: Any) {
        guard let url = URL(string: facebook ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func twitterClicked(_ sender: Any) {
        guard let url = URL(string: twitter ?? "") else { return }
        UIApplication.shared.open(url)
    }
    
    var facebook: String?
    var twitter: String?
    var version: String? {
        didSet {
            self.lblVersion.text = version
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
