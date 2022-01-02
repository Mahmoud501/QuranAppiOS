//
//  THHeader2.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit


//h = 81
class THHeader2: UIView {

    
    @IBOutlet weak var lblTotal: UILabel!
    var countTxt: String? {
        didSet {
            self.lblTotal.text = countTxt
        }
    }
    
    @IBOutlet var contentView: UIView!

     
     override init(frame: CGRect) {
     
         super.init(frame: frame)
         
         commit()
        
     }
          
     
     required init?(coder aDecoder: NSCoder) {
     
         super.init(coder: aDecoder)
         
         commit()
        
     }

     
     func commit(){
     
         Bundle.main.loadNibNamed("THHeader2", owner: self, options: nil)
         
         addSubview(contentView)
         
         contentView.frame = self.bounds
         
         contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
         
         setupUI()
        
     }

     
     func setupUI() {
     
     }
     
    

}
