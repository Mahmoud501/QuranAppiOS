//
//  THHeader1.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

//THHeader1 == Test Home Header1
//h = 194
class THHeader1: UIView {

    var reviewAyatClicked: ( () -> () )?
    
    //
    
    @IBOutlet weak var vuAyaReview: UIView!
    @IBOutlet var contentView: UIView!

    @IBAction func reviewAyatClicked(_ sender: Any) {
        reviewAyatClicked?()
    }
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
        
        commit()
       
    }
         
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
        
        commit()
       
    }

    
    func commit(){
    
        Bundle.main.loadNibNamed("THHeader1", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = self.bounds
        
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
        
        setupUI()
       
    }

    
    func setupUI() {
        vuAyaReview.bor(radius: 12, color: .clear)
        vuAyaReview.shadow2()
    }
    

}
