//
//  UIView+Blur.swift
//  DalilApp
//
//  Created by Mahmoud on 3/29/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func fadeIn(finished: Bool) {
        UIView.animate(withDuration: 1, delay: 0,
                       options: [.curveEaseInOut],
                       animations: { self.alpha = 1 }, completion: {_ in
            self.fadeOut(finished: finished)
        })
    }

    func fadeOut(finished: Bool) {
        UIView.animate(withDuration: 1, delay: 0,
                       options: [.curveEaseInOut],
                       animations: {
            self.alpha = 0.2
        }, completion: self.fadeIn)
    }
    
}
