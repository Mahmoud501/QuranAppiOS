//
//  TestedAyat+Swip.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/24/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit

extension TestedAyat: SwipeTableViewCellDelegate {
    
    var swipColor: UIColor {
        get {
            return UIColor.c5
        }
    }
    
    var textColor: UIColor {
           get {
               return UIColor.black
           }
       }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let swipDirection = UIApplication.isArabic == true ? SwipeActionsOrientation.left : SwipeActionsOrientation.right
        guard orientation == swipDirection else { return nil }

        let clearAction = SwipeAction(style: .default, title: "Clear") { action, indexPath in
            // handle action by updating model with deletion
        }
        clearAction.textColor = textColor
        clearAction.backgroundColor = swipColor
        // customize the action appearance
        clearAction.image = UIImage(named: "clear-icon")

        let markAction = SwipeAction(style: .default, title: "Mark") { action, indexPath in
            // handle action by updating model with deletion
        }
        markAction.textColor = textColor
        markAction.backgroundColor = swipColor
        // customize the action appearance
        markAction.image = UIImage(named: "mark-notmarked")

        
        let shareAction = SwipeAction(style: .default, title: "Share") { action, indexPath in
            // handle action by updating model with deletion
        }
        shareAction.textColor = textColor
        shareAction.backgroundColor = swipColor
        // customize the action appearance
        shareAction.image = UIImage(named: "share-icon")

        
        
        return [shareAction, markAction, clearAction]
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .none
        options.transitionStyle = .border
        return options
    }
    
    
    
}
