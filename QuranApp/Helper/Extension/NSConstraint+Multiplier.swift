//
//  NSConstraint+Multiplier.swift
//  DalilApp
//
//  Created by Mahmoud on 3/23/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    @discardableResult
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
