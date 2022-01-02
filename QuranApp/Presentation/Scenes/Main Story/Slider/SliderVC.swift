//
//  SliderVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

struct ListInfo {
    
    var img: String
    var title: String
    var desc: String
    
}

class SliderVC: UIViewController,AnimationProtocol  {
    
    ///            varibalbes
    
    var arr: [ListInfo] = []
    var current_index = 0

    
    var img: UIImageView {
        get {
            return imgIcon
        }
    }
    

    @IBOutlet weak var imgIcon: UIImageView!
    
        ////                            outlets
        
        @IBOutlet weak var vuBack: UIView!
        @IBOutlet weak var btnNext: UIButton!
        @IBOutlet weak var CVList: UICollectionView!
        @IBOutlet weak var Pager: UIPageControl!
        @IBOutlet weak var WConstraintNextbtn: NSLayoutConstraint!
        
        ///             actions
        
        @IBAction func nextClicked(_ sender: Any) {
            if current_index == (arr.count - 1) {
                let vc = OptionVC.createVC()
                vc.transitioningDelegate = self
                self.present(vc, animated: true, completion: nil)
                return
            }
            
            CVList.scrollToItem(at: IndexPath.init(item: current_index + 1, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            itemDidChange(current_index + 1)
        }
        
        @IBAction func previousClicked(_ sender: Any) {
            if current_index == 0 {
                return
            }

            CVList.scrollToItem(at: IndexPath.init(item: current_index - 1, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
            itemDidChange(current_index - 1)

            
        }
        
        
        ///            life cyle
        override func viewDidLoad() {
            super.viewDidLoad()
            setupData()
            setupUI()            
        }
        
        
        ///            setupUI
        
        func setupUI() {
            vuBack.alpha = 0
            btnNext.layer.cornerRadius = 5
            btnNext.layer.masksToBounds = true
            Pager.numberOfPages = arr.count
            CVList.isScrollEnabled = false
        }

        func change(width with: CGFloat) {
            if WConstraintNextbtn == nil {
                return
            }
            let constraint = WConstraintNextbtn.constraintWithMultiplier(with)
            view.removeConstraint(WConstraintNextbtn)
            view.addConstraint(constraint)
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            }) { (com) in
                self.WConstraintNextbtn = constraint
            }
        }
        
        ///                 setup Data
        
        
        func setupData() {
            arr.append(ListInfo(img: "quranapp-icons-slider-4", title: "intro.title.1".localized, desc: "intro.desc.1".localized))
            
            arr.append(ListInfo(img: "quranapp-icons-slider-3", title: "intro.title.2".localized, desc: "intro.desc.2".localized))
            
            arr.append(ListInfo(img: "quranapp-icons-slider-1", title: "intro.title.3".localized, desc: "intro.desc.3".localized))
        }
        
        
        
        ///                     else

    
    

}


extension SliderVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SplachCell
        cell.item = arr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         if let indexPath = CVList.indexPathsForVisibleItems.first {
            itemDidChange(indexPath.row)
         }
     }
    
    func itemDidChange(_ row: Int) {
        Pager.currentPage = row
                   current_index = row
                   if row == (arr.count - 1) {
                       change(width: 0.7)
                    btnNext.setTitle("Start".localized, for: .normal)
                   }else {
                       change(width: 0.35)
                       btnNext.setTitle("Next".localized, for: .normal)
                   }
                   if row == 0 {
                       vuBack.alpha = 0
                   }else {
                       vuBack.alpha = 1
                   }
    }
}



extension SliderVC {
    
    static func createVC() -> SliderVC {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SliderVC") as! SliderVC
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    
    static func createNav() -> UINavigationController {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "navSlider") as! UINavigationController
        return vc
    }
    
}

extension SliderVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
}


extension SliderVC: UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        var finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        if UIApplication.isArabic == true {
            finalFrameForVC.origin.x = UIScreen.main.bounds.size.width * -1
        }else {
            finalFrameForVC.origin.x = UIScreen.main.bounds.size.width
        }
        
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 1
        
        containerView.addSubview(toViewController.view)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            var newfromFrame = fromViewController.view.frame
            var newtoFrame = toViewController.view.frame

            if UIApplication.isArabic == true {
                newfromFrame.origin.x = UIScreen.main.bounds.size.width                
            }else {
                newfromFrame.origin.x = UIScreen.main.bounds.size.width * -1
            }
            newtoFrame.origin.x = 0
            fromViewController.view.frame = newfromFrame
            
            newtoFrame.origin.x = 0
            toViewController.view.frame = newtoFrame

            }, completion: {
                finished in
                transitionContext.completeTransition(true)                
        })

    }

}



extension UIView {
    
    func change(width with: CGFloat, conts: NSLayoutConstraint, finish: @escaping (NSLayoutConstraint)->()) {
        let constraint = conts.constraintWithMultiplier(with)
        self.removeConstraint(conts)
        self.addConstraint(constraint)
        UIView.animate(withDuration: 0.5, animations: {
           self.layoutIfNeeded()
        }) { (com) in
            finish( constraint)

        }

         
    }
}
