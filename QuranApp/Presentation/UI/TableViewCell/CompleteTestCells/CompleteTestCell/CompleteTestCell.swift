//
//  HomeSurhaCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class CompleteTestCell: UITableViewCell {

    @IBOutlet weak var lblQuestion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    

    var ayah: dataCom? {           
        didSet {
            if ayah?.isCom == true {
                self.backgroundColor = .c5
                self.lblQuestion.text = ayah?.ayah?.desc?.split(separator: " ")[0].description
            }else {
                if (ayah?.error ?? "") != "" {
                    self.backgroundColor = .c5
                    self.lblQuestion.text = ayah?.error
                }else {
                    self.backgroundColor = .white
                    self.lblQuestion.text = ayah?.ayah?.desc
                }
            }
            self.lblQuestion.attributedText = String.colorText(text: self.lblQuestion.text!, searchText: ["(", ")"])
            let font = UIFont.init(name: "Cairo-Bold", size: AppFactory.isIPad == true ? 24 : 12)
            self.lblQuestion.font = font

        }
    }
    
    
}
