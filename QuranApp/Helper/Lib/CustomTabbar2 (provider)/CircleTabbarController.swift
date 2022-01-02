//
//  CircleTabbarController.swift
//  DalilApp
//
//  Created by Mahmoud on 4/1/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import UIKit

class CircleTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMiddleButton()
        
    }
    
}


extension CircleTabbarController
{
    //setup Middle Button
    func setupMiddleButton()
    {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-40, y: -45, width: 80, height: 80))

        //STYLE THE BUTTON YOUR OWN WAY
        middleBtn.setBackgroundImage(UIImage(named: "Group 2221"), for: .normal)
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)

        self.view.layoutIfNeeded()
        hanldeClick()
    }
    
    //this function for handle clicked on half button that exist outer of tabbar
    func hanldeClick()
    {
         let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
         var menuButtonFrame = menuButton.frame
         menuButtonFrame.origin.y = (view.bounds.height - menuButtonFrame.height) - 10
         menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
         menuButton.frame = menuButtonFrame
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
         self.view.addSubview(menuButton)
         menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

         self.view.layoutIfNeeded()
     }
    
    @objc func menuButtonAction(sender: UIButton)
    {
        print("Soon")
//        let addVC = AddRouter.createAddVC()
//        self.present(addVC, animated: true)
        let alert = UIAlertController.init(title: "Add Product", message: "Coming Soon", preferredStyle: .alert)
        let action1 = UIAlertAction.init(title: "Ok", style: .default, handler: nil)
        alert.addAction(action1)
        self.present(alert, animated: true, completion: nil)
    }
    


}

