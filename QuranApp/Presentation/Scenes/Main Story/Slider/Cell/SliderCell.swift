//
//  SplachCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

class SplachCell: UICollectionViewCell {
 
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    var item: ListInfo? {
        didSet {
            self.Img.image = UIImage.init(named: item?.img ?? "")
            self.lblDesc.text = item?.desc
            self.lblTitle.text = item?.title
        }
    }
    
}
