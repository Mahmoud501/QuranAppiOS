//
//  PopupDetailRouter.swift
//  ShopApp
//
//  Created by MAJED A  ALGARNI on 7/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

class TafseerPopupMenuRouter {
    
    static func createVC(delegate: TafseerPopupMenuDelegate? = nil, orderAyat: [CAyatModel]?) -> UIViewController {
        let vc = TafseerPopupMenu.init(nibName: "TafseerPopupMenu", bundle: nil)
        vc.view.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        vc.modalPresentationStyle = .overFullScreen
        vc.orderAyat = orderAyat
        vc.delegate = delegate
        return vc
    }
    
}
