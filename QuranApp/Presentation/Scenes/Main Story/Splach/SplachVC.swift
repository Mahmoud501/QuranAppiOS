//
//  SplachVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class SplachVC: BaseViewController,AnimationProtocol {
    
    
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
            
    @IBOutlet weak var imgIcon: UIImageView!
    var quran = QuranRepo.init()

    var img: UIImageView {
        get {
            return imgIcon
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.setupSplach()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        install()
        
        
    }
    
    func install() {
        
        quran.installQuran(finish: { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.GoToNext()
            }
            
        }) { [weak self] (process, desc) in
            guard let self = self else { return }
            print(desc)
            self.lblInfo.text = desc
            UIView.animate(withDuration: 0.5) {
                self.progressBar.progress = Float(process)
            }
        }
    }
    

    func GoToNext() {
        let nav = SliderVC.createVC()
        nav.transitioningDelegate = self
        nav.modalPresentationStyle = .overFullScreen
        self.present(nav, animated: true, completion: nil)

    }


}


extension SplachVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
}


protocol AnimationProtocol {
    var img: UIImageView { get }
}


extension SplachVC: UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
      //  let toViewController = ((nav as! UINavigationController).viewControllers.first)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 0
        containerView.addSubview(toViewController.view)
        let img1 = (fromViewController as! AnimationProtocol).img
        let img2 = (toViewController as! AnimationProtocol).img
        let frm = img1.convert(img1.bounds, to: fromViewController.view)
        let snapshot = img1.snapshotView(afterScreenUpdates: false)
        snapshot?.contentMode = .scaleAspectFill
        snapshot?.frame = frm
        if let snapshot = snapshot {
            fromViewController.view.bringSubviewToFront(snapshot)
            fromViewController.view.addSubview(snapshot)
        }        
        img1.alpha = 0
        img2.alpha = 0
        for item in toViewController.view.subviews {
            item.alpha = 0
        }
        var finalFrameForIcon = img2.convert(img2.bounds, to: toViewController.view)
        let safeViewHeigth = toViewController.view.safeAreaInsets.top
        finalFrameForIcon.origin.y = finalFrameForIcon.origin.y + safeViewHeigth
        let lang = UserDefaults.standard.object(forKey: "loclz") as? String
        if lang == "ar" {
            finalFrameForIcon.origin.x = (UIScreen.main.bounds.size.width - finalFrameForIcon.origin.x) -  finalFrameForIcon.size.width
        }
        print(finalFrameForIcon)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            snapshot?.frame = finalFrameForIcon
            for item in fromViewController.view.subviews {
                if item != snapshot {
                    item.alpha = 0
                }
            }
                       
            }, completion: {
                finished in
                transitionContext.completeTransition(true)
                toViewController.view.alpha = 1.0                
                img2.alpha = 1
                img1.alpha = 0
                UIView.animate(withDuration: 1) {
                    for item in toViewController.view.subviews {                                                        
                        item.alpha = 1
                    }
                }
        })

    }

//    static func home(animatedUIView: UIView) {
//        if #available(iOS 13.0, *){
//
//        }else {
//            let loginVC = HomeVC.createVC()
//            animatedUIView.viewContainingController()?.present(loginVC, animated: true, completion: nil)
//            return
//        }
//
//        let loginVC = HomeVC.createVC()
//        var frm = loginVC.view.frame
//        frm.size.width = UIScreen.main.bounds.width
//        frm.size.height = UIScreen.main.bounds.height
//        loginVC.view.frame = frm
//        loginVC.modalTransitionStyle = .partialCurl
//        loginVC.modalPresentationStyle = .fullScreen
//        UIView.animate(withDuration: 1, animations: {
//            let animation = CATransition()
//            animation.duration = 1.2
//            animation.startProgress = 0.0
//            animation.endProgress = 1
//            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
//            animation.type = CATransitionType(rawValue: "pageCurl")
//            animation.subtype = CATransitionSubtype(rawValue: "fromRight")
//            animation.isRemovedOnCompletion = false
//            animation.fillMode = CAMediaTimingFillMode(rawValue: "extended")
//            animatedUIView.layer.add(animation, forKey: "pageFlipAnimation")
//            animatedUIView.addSubview(loginVC.view)
//
//        }) { (com) in
//            guard var window = UIApplication.shared.keyWindow else {
//                return
//            }
//            window.rootViewController?.dismiss(animated: false, completion: {
//            })
//            window.rootViewController = loginVC
//            window.makeKeyAndVisible()
//
//            }
//
//
//    }
//
    
    static func home(animatedUIView: UIView) {
        let loginVC = HomeVC.createVC()
        var frm = loginVC.view.frame
        frm.size.width = UIScreen.main.bounds.width
        frm.size.height = UIScreen.main.bounds.height
        loginVC.view.frame = frm
        loginVC.modalTransitionStyle = .partialCurl
        loginVC.modalPresentationStyle = .fullScreen
        UIView.animate(withDuration: 1, animations: {
            let animation = CATransition()
            animation.duration = 1.2
            animation.startProgress = 0.0
            animation.endProgress = 1
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            animation.type = CATransitionType(rawValue: "pageCurl")
            animation.subtype = CATransitionSubtype(rawValue: "fromRight")
            animation.isRemovedOnCompletion = false
            animation.fillMode = CAMediaTimingFillMode(rawValue: "extended")
            animatedUIView.layer.add(animation, forKey: "pageFlipAnimation")
            animatedUIView.addSubview(loginVC.view)

        }) { (com) in
            
            guard var window = UIApplication.shared.keyWindow else {
                return
            }
            
            if #available(iOS 13.0, *){
                window.rootViewController?.dismiss(animated: false, completion: {
                })
                window.rootViewController = loginVC
                window.makeKeyAndVisible()

            }else {
                //window = UIWindow(frame: UIScreen.main.bounds)
                window.rootViewController?.dismiss(animated: false, completion: {
                    
                    window.rootViewController = loginVC
                    window.makeKeyAndVisible()
                })

            }
            
            
        }
    }

    
}

extension SplachVC {
    
    static func createVC() -> SplachVC {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SplachVC") as! SplachVC
        return vc
    }
    
}
