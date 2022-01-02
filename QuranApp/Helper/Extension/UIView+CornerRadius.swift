//
//  UIView+CornerRadius.swift
//  VillageApp
//
//  Created by Mahmoud on 7/28/1398 AP.
//  Copyright © 1398 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func setCornerRadius(_ value: CGFloat)
    {
        DispatchQueue.main.async {
            self.layer.cornerRadius = value
            self.layer.masksToBounds = true
        }
    }
    
    func setCirleCornerRadius()
    {
        if AppFactory.isIPad {
            DispatchQueue.main.async {
                self.layer.cornerRadius = self.frame.size.height / 2
                self.layer.masksToBounds = true
            }
        }else {
            self.layer.cornerRadius = self.frame.size.height / 2
            self.layer.masksToBounds = true
        }
    }
}
