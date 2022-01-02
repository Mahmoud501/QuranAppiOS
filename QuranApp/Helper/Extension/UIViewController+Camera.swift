//
//  UIViewController+Camera.swift
//  Wagb3aza
//
//  Created by Mahmoud on 7/1/1398 AP.
//  Copyright © 1398 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func takePhoto(sender: UIViewController,type : UIImagePickerController.SourceType) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            let picker = UIImagePickerController()
            picker.delegate = sender as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
            picker.sourceType = type
            picker.allowsEditing = true
            sender.present(picker, animated: true, completion: nil)
        }
        else{
            NSLog("No Camera.")
        }
    }
    
    func showPickerImgOptions()
    {
        let optionMenu = UIAlertController(title: nil, message: "إختار", preferredStyle: .actionSheet)
        let CameraAction = UIAlertAction(title: "الكاميرا", style: .default) { (UIAlertAction) in
            self.takePhoto(sender: self,type: UIImagePickerController.SourceType.camera)
        }
        let LibraryPhotoAction = UIAlertAction(title:"معرض الصور", style: .default) { (UIAlertAction) in
            self.takePhoto(sender: self,type: UIImagePickerController.SourceType.photoLibrary)
        }
        // 3
        let cancelAction = UIAlertAction(title:"إلغاء", style: .cancel)
        // 4
        optionMenu.addAction(CameraAction)
        optionMenu.addAction(LibraryPhotoAction)
        optionMenu.addAction(cancelAction)
        // 5
        optionMenu.modalPresentationStyle = .popover
        if let popoverController = optionMenu.popoverPresentationController {
            popoverController.sourceView = self.view //to set the source of your alert
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
            popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
        }
        self.present(optionMenu, animated: true, completion: nil)
    }
}
