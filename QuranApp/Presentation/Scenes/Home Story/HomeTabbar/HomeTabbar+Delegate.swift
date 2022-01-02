//
//  HomeTabbar+Delegate.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit

extension HomeTabbarController: HomePopupMenuDelegate {
    
    func didDismissViewController() {
        UIView.animate(withDuration: 0.5) {
            self.viewControllers?.first?.view.alpha = 1
        }
    }
    
    
}
