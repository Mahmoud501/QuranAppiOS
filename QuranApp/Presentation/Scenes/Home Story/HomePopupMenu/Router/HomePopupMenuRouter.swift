//
//  PopupDetailRouter.swift
//  ShopApp
//
//  Created by MAJED A  ALGARNI on 7/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

class HomePopupMenuRouter {
    
    static func createVC(text: String? = nil, delegate: HomePopupMenuDelegate? = nil) -> UIViewController {
        let vc = HomePopupMenu.init(nibName: "HomePopupMenu", bundle: nil)
        vc.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = delegate
        if text != nil {
            vc.text = text
        }
        return vc
    }
    
}
