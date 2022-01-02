//
//  UIViewController+SwiftMessageStatusBar.swift
//  EventHub
//
//  Created by Mahmoud on 4/4/1398 AP.
//  Copyright © 1398 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UIView
{
    func moveViewToBottom(){

    }
    
    func backViewToTop(){
        UIView.animate(withDuration: 0.5) {
            var frame = self.frame
            frame.origin.y = 0
            self.frame = frame
        }        
    }
}
