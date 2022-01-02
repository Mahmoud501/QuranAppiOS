//
//  HomeAyaCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import SwipeCellKit

class WordOptionCell: SwipeTableViewCell {

    var didSelectSection : ((Bool) -> ())?

    
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var lblOption: UILabel!
    
    
    @IBAction func selectClicked(_ sender: Any) {
        self.backgroundColor = UIColor.c3.withAlphaComponent(0.4)
        didSelectSection?(true)
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
