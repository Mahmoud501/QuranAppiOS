//
//  HomeHeadView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class HomeHeadView: UIView {
    
    var didSelectSection : (() -> ())?
    
    ///
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imgSelect: UIImageView!
    
    @IBAction func selectDidClicked(_ sender: Any) {        
        didSelectSection?()
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
        Bundle.main.loadNibNamed("HomeHeadView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
        setupUI()
    }

    func setupUI() {
        vuContain.shadow()
    }
    
    var titleHeader: String? {
        didSet {
            self.lblTitle.text = titleHeader
        }
    }
    
    var cellIsSelected: Bool? {
        didSet {
            if cellIsSelected == true {
                imgSelect.image = UIImage.init(named: "checkbox-selected")
            }else {
                imgSelect.image = UIImage.init(named: "Ellipse 1")
            }
        }
    }

}
