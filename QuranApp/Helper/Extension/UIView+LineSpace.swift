//
//  UIView+LineSpace.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 10/25/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func updateWithSpacing(lineSpacing: Float) {
        // The attributed string to which the
        // paragraph line spacing style will be applied.
        let attributedString = NSMutableAttributedString.init(attributedString: self.attributedText!)
        let mutableParagraphStyle = NSMutableParagraphStyle()
        // Customize the line spacing for paragraph.
        mutableParagraphStyle.lineSpacing = CGFloat(lineSpacing)

        if let stringLength = self.text?.count {
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: mutableParagraphStyle, range: NSMakeRange(0, stringLength))
        }
        // textLabel is the UILabel subclass
        // which shows the custom text on the screen
        self.attributedText = attributedString        
        // currentValueLabel is the label which displays
        // the  current value of UISlider (Which in turn is the line spacing).
        // This can be changed on the fly by sliding the UISlider.
        //self.text = String(format: "%.1f", lineSpacing)
    }
    
}
