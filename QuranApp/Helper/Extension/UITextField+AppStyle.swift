//
//  UITextField+AppStyle.swift
//  VillageApp
//
//  Created by Mahmoud on 7/28/1398 AP.
//  Copyright © 1398 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UITextField
{
    func setAppStyle()
    {
        self.addPaddingSpace(space: 20)
        self.addRigthPaddingSpace(space: 20)
        self.bor(8)
        self.shadow()
    }
}

extension UITextView
{
    func setAppStyle()
    {
        self.bor(8)
        self.clipsToBounds = true
    }
}
   
extension UIView
{
    func setAppStyleTextView()
    {
        self.bor(8)
        self.clipsToBounds = false
        self.shadow()
    }
}
   
