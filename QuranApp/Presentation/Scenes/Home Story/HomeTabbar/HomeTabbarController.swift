//
//  HomeTabbarController.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import ZVProgressHUD

class HomeTabbarController: UITabBarController {

    var tabhide : Bool = false 
    var buttonCenterRef: UIButton!
    var buttonStartRef: UIButton!
    var pulseEffect: LFTPulseAnimation!
    var speech: DSpeechRecognition! = nil
    var textSearch: String?
    
    //
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let nav = self.viewControllers?[1] as? UINavigationController
        nav?.viewControllers.append(TestHomeVC.createVC())
        
        let nav2 = self.viewControllers?[2] as? UINavigationController
        nav2?.viewControllers.append(SearchVoiceHomeVC.createVC())
        
        let nav3 = self.viewControllers?[3] as? UINavigationController
        nav3?.viewControllers.append(AboutusVC.createVC())
        
        let nav4 = self.viewControllers?[4] as? UINavigationController
        nav4?.viewControllers.append(SettingHomeVC.createVC())
        
        setupMiddleButton()
        setupFirstButton()

        self.buttonCenterRef.alpha = 1


    }

}

extension UITabBarController {
    
    var custom: HomeTabbarController? {
        get {
            return self as? HomeTabbarController
        }
    }
    
}

extension HomeTabbarController {
    
    //setup Middle Button
     func setupFirstButton() {
        let fullWidth = self.tabBar.frame.width / 5
        let lang = UserDefaults.standard.object(forKey: "loclz") as? String
        let x = lang == "en" ? 0 : (self.tabBar.frame.size.width - fullWidth)
         let firstBtn = UIButton(frame: CGRect(x: x , y: 0, width: fullWidth, height: 60))
        buttonStartRef = firstBtn
         //STYLE THE BUTTON YOUR OWN WAY
         //add to the tabbar and add click event
        self.tabBar.addSubview(firstBtn)
        self.view.layoutIfNeeded()
        firstBtn.addTarget(self, action: #selector(menuFirstButtonAction(sender:)), for: .touchUpInside)
    }
    
    //setup Middle Button
    func setupMiddleButton() {
        let middleBtn = UIButton(frame: CGRect(x: (self.tabBar.bounds.width / 2)-25, y: -20, width: 60, height: 60))
        //STYLE THE BUTTON YOUR OWN WAY
        //add to the tabbar and add click event
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        self.view.layoutIfNeeded()
        hanldeClick()
    }
    
    //this function for handle clicked on half button that exist outer of tabbar
    func hanldeClick() {
         let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
         var menuButtonFrame = menuButton.frame
         menuButtonFrame.origin.y = 0
         menuButtonFrame.origin.x = tabBar.bounds.width/2 - menuButtonFrame.size.width/2
         menuButton.frame = menuButtonFrame
           menuButton.layer.cornerRadius = menuButtonFrame.height/2
         self.tabBar.addSubview(menuButton)
        buttonCenterRef = menuButton
         menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        let longPress = UILongPressGestureRecognizer.init(target: self, action:  #selector(menuLongButtonAction(sender:)))
        longPress.minimumPressDuration = 0.5
        longPress.delaysTouchesBegan = true
        menuButton.addGestureRecognizer(longPress)
         self.view.layoutIfNeeded()
     }
    
    
    @objc func menuFirstButtonAction(sender: UIButton) {
        if selectedIndex == 0 {
            print("ff11rrrrf")
            
            UIView.animate(withDuration: 0.5) {
                self.viewControllers?.first?.view.alpha = 0.6
            }
            
            let vc = HomePopupMenuRouter.createVC(text: "dd",delegate: self)
            self.present(vc, animated: true, completion: nil)
        }else {
            self.selectedIndex = 0
        }
         
     }
    
    @objc func menuButtonAction(sender: UIButton) {
        print("fff")
        self.selectedIndex = 2
    }
    
    @objc func menuLongButtonAction(sender: UILongPressGestureRecognizer) {
        
        
        if sender.state == .began {
//            print("began")
//            if speech == nil {
//                speech = DSpeechRecognition(local: "ar")
//                speech.setupSpeech()
//                if speech.isRunning == true {
//                               return
//                           }
//                        self.speech.startRecording { [weak self] (text) in
//                            guard let self = self else { return }
//                            self.textSearch = text
//                        }
//                        let postion = self.buttonCenterRef.convert(self.buttonCenterRef.bounds, to: self.view)
//                        self.pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius:20, position:
//                        CGPoint.init(x: postion.origin.x + (postion.size.width / 2) , y: postion.origin.y + (postion.size.height / 2)))
//                        self.pulseEffect.radius = self.view.bounds.width/2
//                        self.pulseEffect.backgroundColor = UIColor.red.cgColor
//                        self.view.layer.insertSublayer(self.pulseEffect, below: self.buttonCenterRef.layer)
//            }

    }
               
               
        if sender.state == .failed || sender.state == .cancelled {
            print("nope")
            //stopRecord()
        }
               
               
        if sender.state == .ended {
            print("ccc")
            //stopRecord()
        }
        

    }
    func stopRecord() {
        if speech.isRunning == false {
            return
        }
        ZVProgressHUD.show()
        self.pulseEffect.removeFromSuperlayer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.speech.stopRecording()
            AudioServicesPlaySystemSound(1114)
            ZVProgressHUD.dismiss()
            let ayah = SearchVoicePresenter.getAyahByVoiceText(text: self.textSearch)
            print(self.textSearch)
            if let ayah = ayah {
                self.selectedIndex = 0
                AppFactory.homeVC?.search(ayah: ayah)
            }else {
                AlertClass2.ShowErrorStatusBar(vc: self, message: "search result not found".localized)
            }
            self.speech = nil
        }
    }


    var isTabbarHidden: Bool {
          get {
                return tabhide
          }
      }
      
    func hideTabbar(_ hideAnimated: Bool? = nil) {
        self.sideMenuController?.isLeftViewSwipeGestureDisabled = true
        self.sideMenuController?.isRightViewSwipeGestureDisabled = true
        tabhide = true
        self.buttonCenterRef.alpha = 0
        self.buttonStartRef.alpha = 0
        let duration = (hideAnimated ?? false) == false ? 0.25 : 0.0001
        UIView.animate(withDuration: duration, animations: {
            var frm = self.tabBar.frame
            frm.origin.y = UIScreen.main.bounds.height
            self.tabBar.frame = frm
        }) { (com) in
            self.tabBar.isHidden = true
            self.tabBar.alpha = 0
        }
          
      }
      
      func showTabbar(_ hideAnimated: Bool? = nil) {
        self.sideMenuController?.isLeftViewSwipeGestureDisabled = false
        self.sideMenuController?.isRightViewSwipeGestureDisabled = false
        tabhide = false
        self.tabBar.isHidden = false
        self.tabBar.alpha = 1
        self.buttonCenterRef.alpha = 1
        self.buttonCenterRef.layer.zPosition = 10
        self.buttonStartRef.alpha = 1
        self.tabBar.bringSubviewToFront(buttonCenterRef)
        let duration = (hideAnimated ?? false) == false ? 0.25 : 0.0001
        UIView.animate(withDuration: duration, animations: {
            var frm = self.tabBar.frame
            let val = UIScreen.main.bounds.height - frm.size.height
            frm.origin.y = val
            self.tabBar.frame = frm

        }) { (com) in
        }
      }
    
}


class CustomTabBar: UITabBar {
 
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var bottom: CGFloat? = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            bottom = window?.safeAreaInsets.bottom
        }
        var size = super.sizeThatFits(size)
        size.height = 50 + (bottom ?? 0)
        return size
     }
}






extension HomeTabbarController {
    
    static func createVC() -> HomeTabbarController {
        
            let vc = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeTabbarController") as! HomeTabbarController
            vc.modalPresentationStyle = .fullScreen
            return vc
        }
}
