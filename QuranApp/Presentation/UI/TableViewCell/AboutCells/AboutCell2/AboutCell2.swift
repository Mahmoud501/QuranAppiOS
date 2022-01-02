//
//  AboutCell2.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import Kingfisher

class AboutCell2: UITableViewCell {

    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPostion: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           Img.setCirleCornerRadius()
           Img.layer.masksToBounds = true
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

           // Configure the view for the selected state
       }
       
    
    var teamMember: TeamMemberModel? {
        didSet {
            let path = "http://quranapp.info/storage/app/public/" + (teamMember?.photo ?? "")
            let url = URL.init(string: path)
            self.Img.kf.setImage(with: url)
            self.Img.kf.indicatorType = .activity
            self.lblName.text = teamMember?.name
            self.lblPostion.text = teamMember?.position
        }
    }
}
