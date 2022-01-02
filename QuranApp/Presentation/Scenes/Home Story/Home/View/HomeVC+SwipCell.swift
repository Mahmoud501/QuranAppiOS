//
//  HomeVC+SwipCell.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit

extension HomeVC: SwipeTableViewCellDelegate {
    
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
        
        if self.presenter?.openAyatOptions == true {
            return nil
        }
        let swipDirection = UIApplication.isArabic == true ? SwipeActionsOrientation.left : SwipeActionsOrientation.right
        guard orientation == swipDirection else { return nil }

        let clearAction = SwipeAction(style: .default, title: "Details".localized) { action, indexPath in
            // handle action by updating model with deletion
            if let cell = tableView.cellForRow(at: indexPath) as? SwipeTableViewCell {
                cell.hideSwipe(animated: true)
                let ayah = self.presenter?.getAyah(section: indexPath.section, row: indexPath.row)
                let vc = AyaDetailVC.createVC(ayah: ayah)
                vc.reload = { [weak self] in
                    guard let self = self else { return }
                    self.TVAyat.reloadData()
                    
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        clearAction.textColor = textColor
        clearAction.backgroundColor = swipColor
        // customize the action appearance
        clearAction.image = UIImage(named: "clear-icon")

        let markAction = SwipeAction(style: .default, title: "Mark".localized) { action, indexPath in
            if let cell = tableView.cellForRow(at: indexPath) as? SwipeTableViewCell {
                cell.hideSwipe(animated: true) { [weak self](com) in
                    guard let self = self else { return }
                    let ayah = self.presenter?.getAyah(section: indexPath.section, row: indexPath.row)
                    self.presenter?.saveMark(ayah: ayah)
                    self.TVAyat.reloadData()
                }
            }
            // handle action by updating model with deletion
        }
        markAction.textColor = textColor
        markAction.backgroundColor = swipColor
        // customize the action appearance
        markAction.image = UIImage(named: "mark-notmarked")

        
        let shareAction = SwipeAction(style: .default, title: "Share".localized) { action, indexPath in
            if let cell = tableView.cellForRow(at: indexPath) as? SwipeTableViewCell {
                cell.hideSwipe(animated: true)
                let ayah = self.presenter?.getAyah(section: indexPath.section, row: indexPath.row)
                self.share(sender: self.view, ayah: ayah)
            }
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
    
    
    func share(sender: UIView, ayah: CAyatModel?){
        
        let surhaName = "سورة" + " " + (ayah?.surha?.name_ar ?? "")
        let ayaNum = "(" + (ayah?.sort.description ?? "") + ")"
        let text_start = "﷽"
        let textToShare = (ayah?.desc ?? "") + " " + ayaNum + " " + surhaName
        let str = """
        \(text_start)
        \(textToShare)
        """
        let objectsToShare = [str as Any] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)        
        //Excluded Activities
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = sender
        self.present(activityVC, animated: true, completion: nil)
    }
}

    

