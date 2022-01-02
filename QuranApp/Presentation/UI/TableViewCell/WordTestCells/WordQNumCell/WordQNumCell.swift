//
//  HomeHeadView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class WordQNumCell: UIView {
    
    var didSelectSection : ((Bool) -> ())?
    
    ///
    
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet var contentView: UIView!
    
    @IBAction func selectDidClicked(_ sender: Any) {
        didSelectSection?(true)
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
        Bundle.main.loadNibNamed("WordQNumCell", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
        setupUI()
    }

    func setupUI() {
       // vuContain.shadow()
    }

}
