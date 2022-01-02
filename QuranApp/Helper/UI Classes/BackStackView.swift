//
//  BackStackView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/29/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class BackStackView: UIStackView {

     override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(back))
        self.addGestureRecognizer(tap)
    }
    
    @objc func back() {
        self.viewContainingController()?.dismiss(animated: true, completion: nil)
        self.viewContainingController()?.navigationController?.popViewController(animated: true)
    }
}
