//
//  ZDSegmentSlider.swift
//  InstagramProfile
//
//  Created by Mahmoud on 3/16/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit
//
//  ScrollDelegate.swift
//  InstagramProfile
//
//  Created by MAJED A  ALGARNI on 3/16/20.
//  Copyright ©️ 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

class ZDSegmentSlider: UIViewController, UIScrollViewDelegate {
    var parentScrollView: CollaborativeScrollView!
    var childScrollView: CollaborativeScrollView!
    var mLockOuterScrollView = false
    var goingUp: Bool? //to track is scrollView is going up or down
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
     if scrollView is CollaborativeScrollView == false { return }

                if scrollView == parentScrollView {
                  let csv = scrollView as! CollaborativeScrollView
                    var directionTemp: Direction?
                    if csv.lastContentOffset.y > csv.contentOffset.y {
                        directionTemp = .up
                    } else if csv.lastContentOffset.y < csv.contentOffset.y {
                        directionTemp = .down
                    }
                    guard let direction = directionTemp else {return}
                    if csv === childScrollView {
                        let isAlreadyAllTheWayUp = childScrollView.contentOffset.y == 0
                        if  (direction == .up && isAlreadyAllTheWayUp) {
                            mLockOuterScrollView = false
                        } else {
                            mLockOuterScrollView = true
                        }
                    } else if mLockOuterScrollView {
                        parentScrollView.contentOffset = parentScrollView.lastContentOffset
                    }else if csv === parentScrollView {
                                            if direction == .down && scrollView.contentOffset.y > 0{
                                                scrollView.bounces = false
                                                scrollView.bouncesZoom = false
                                                scrollView.alwaysBounceVertical = false
                                            }else{
                                                scrollView.bounces = true
                                                scrollView.bouncesZoom = true
                                                scrollView.alwaysBounceVertical = true
                                            }

                    }

                    csv.lastContentOffset = csv.contentOffset

                }else {
                    let csv = scrollView as! CollaborativeScrollView
                    var directionTemp: Direction?
                    if csv.lastContentOffset.y > csv.contentOffset.y {
                        directionTemp = .up
                    } else if csv.lastContentOffset.y < csv.contentOffset.y {
                        directionTemp = .down
                    }
                    guard let direction = directionTemp else {return}
                   
                    //lock outer scrollview if necessary
                    if csv === childScrollView {
                         
    //                    let isAlreadyAllTheWayDown = (childScrollView.contentOffset.y + childScrollView.frame.size.height) == childScrollView.contentSize.height
                        let isAlreadyAllTheWayUp = childScrollView.contentOffset.y <= 0
                        print(childScrollView.contentOffset.y)
    //                    if mLockOuterScrollView == true && childScrollView.contentOffset.y > 0 {
    //                        mLockOuterScrollView = false
    //                    }
                        if (direction == .up && isAlreadyAllTheWayUp) {
                            mLockOuterScrollView = false
                            scrollView.bounces = false
                            scrollView.bouncesZoom = false
                            scrollView.alwaysBounceVertical = false

                        } else {
                            scrollView.bounces = true
                            scrollView.bouncesZoom = true
                            scrollView.alwaysBounceVertical = true

                            mLockOuterScrollView = true
                        }
                    } else if mLockOuterScrollView {
                        parentScrollView.contentOffset = parentScrollView.lastContentOffset
                    }

                    csv.lastContentOffset = csv.contentOffset

                }
                  //determine direction of scrolling
            
            
            // 1: determining whether scrollview is scrolling up or down
            goingUp = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
            
            // 2: maximum contentOffset y that parent scrollView can have
            let parentViewMaxContentYOffset = parentScrollView.contentSize.height - parentScrollView.frame.height
            
            // 3: if scrollView is going upwards
            if goingUp! {
                // 4:  if scrollView is a child scrollView
                
                if scrollView == childScrollView {
                    // 5:  if parent scroll view is't scrolled maximum (i.e. menu isn't sticked on top yet)
                    if parentScrollView.contentOffset.y < parentViewMaxContentYOffset {
                        
                        // 6: change parent scrollView contentOffset y which is equal to minimum between maximum y offset that parent scrollView can have and sum of parentScrollView's content's y offset and child's y content offset. Because, we don't want parent scrollView go above sticked menu.
                        // Scroll parent scrollview upwards as much as child scrollView is scrolled
                        parentScrollView.contentOffset.y = min(parentScrollView.contentOffset.y + childScrollView.contentOffset.y, parentViewMaxContentYOffset)
                        
                        // 7: change child scrollView's content's y offset to 0 because we are scrolling parent scrollView instead with same content offset change.
                        childScrollView.contentOffset.y = 0
                    }
                }
            }
                // 8: Scrollview is going downwards
           
        }

}
