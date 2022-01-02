//
//  ReciterCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class ReciterCell: UITableViewCell {

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var vuStatus: UIView!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vuContain.bor(radius: 13, color: .clear)
        if UIApplication.isArabic == true {
            Img.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }else {
            Img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
        
        Img.layer.cornerRadius = 13
        Img.layer.masksToBounds = true
        vuStatus.bor(radius: 7, color: .clear)
        vuContain.shadow()
    }
    
    var reciter: CReciter? {
        didSet {
            if AppFactory.isArabic == true {
                self.lblName.text = reciter?.name_ar
            }else {
                self.lblName.text = reciter?.name_en
            }
            self.Img.image = UIImage.init(named: reciter?.image_path ?? "")
            if (reciter?.type ?? 0) == ReciterType.Murattal.rawValue {
                self.vuStatus.backgroundColor = .c2
                self.lblStatus.text = "Murattal".localized
            }else if (reciter?.type ?? 0) == ReciterType.Mujawad.rawValue {
                self.vuStatus.backgroundColor = .red
                self.lblStatus.text = "Mujawad".localized
            }else if (reciter?.type ?? 0) == ReciterType.Muallim.rawValue {
                self.vuStatus.backgroundColor = .orange
                self.lblStatus.text = "Muallim".localized
            }else if (reciter?.type ?? 0) == ReciterType.Translate.rawValue {
                self.vuStatus.backgroundColor = .black
                self.lblStatus.text = "Translate".localized
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
