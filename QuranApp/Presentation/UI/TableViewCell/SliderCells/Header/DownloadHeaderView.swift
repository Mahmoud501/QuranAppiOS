//
//  DownloadHeaderView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/16/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class DownloadHeaderView: UIView {

    var downDidClicked:(()->())?
    
    
    //
    
    @IBOutlet var contentView: UIView!
    
    //
    
    @IBAction func downloadAllDidClicked(_ sender: Any) {
        downDidClicked?()
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
        Bundle.main.loadNibNamed("DownloadHeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
    }
 

}
