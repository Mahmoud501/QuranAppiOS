//
//  PopupDetailRouter.swift
//  ShopApp
//
//  Created by MAJED A  ALGARNI on 7/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

class TestPopupMenuRouter {
    
    static func createVC(delegate: TestPopupMenuDelegate? = nil) -> UIViewController {
        let vc = TestPopupMenu.init(nibName: "TestPopupMenu", bundle: nil)
        vc.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = delegate
        return vc
    }
    
}
