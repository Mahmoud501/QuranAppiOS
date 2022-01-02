//
//  CollaborativeScrollView.swift
//  InstagramProfile
//
//  Created by Mahmoud on 3/16/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

class CollaborativeScrollView: UIScrollView, UIGestureRecognizerDelegate {

    var lastContentOffset: CGPoint = CGPoint(x: 0, y: 0)

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return otherGestureRecognizer.view is CollaborativeScrollView
    }
}

