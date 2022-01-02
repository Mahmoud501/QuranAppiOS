//
//  TestPopupMenu.swift
//  ShopApp
//
//  Created by MAJED A  ALGARNI on 7/15/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

protocol TestPopupMenuDelegate: class {
    func didTapClearWrongWrite()
    func didDismissViewController()
    func didTapWriteTest()
    func didTapVoice()
    func didTapWordTest()
    func didTapSortTest()
    func didTapCompleteAyatTest()
}

class TestPopupMenu: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    var initialTouchPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    var text: String?
    weak var delegate: TestPopupMenuDelegate?
    
    var vc: UIViewController!
    
    //
    
    
    
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var vuDrag: UIView!
    @IBOutlet weak var vuDragLine: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vuDrag.layer.cornerRadius = 10
        vuDrag.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vuDrag.layer.masksToBounds = true
        vuDragLine.layer.cornerRadius = vuDragLine.frame.size.height / 2
        vuDragLine.layer.masksToBounds = true
        //vuContain.delegate = self
    }
    
    
    @IBAction func clearWrongWriteClicked(_ sender: Any) {
        close { [weak self] in
            guard let self = self else { return }
            self.delegate?.didTapClearWrongWrite()
        }
    }
    
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        close { [weak self] in
            guard let self = self else { return }
            if sender.tag == 1 {
                self.delegate?.didTapWriteTest()
            }else if sender.tag == 2 {
                self.delegate?.didTapVoice()
            }else if sender.tag == 3 {
                self.delegate?.didTapWordTest()
            }else if sender.tag == 4 {
                self.delegate?.didTapSortTest()
            }else if sender.tag == 5 {
                self.delegate?.didTapCompleteAyatTest()
            }
        }
    }
    
    
    
    @IBAction func tapClicked(_ sender: Any) {
        close()
    }
    
    
    @IBAction func dragView(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)
        if sender.state == UIGestureRecognizer.State.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizer.State.changed {
            print(touchPoint)
            if touchPoint.y - initialTouchPoint.y > 0{
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizer.State.ended || sender.state == UIGestureRecognizer.State.cancelled {
            if touchPoint.y - initialTouchPoint.y > self.vuContain.frame.height * 0.25 {
                delegate?.didDismissViewController()
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         if scroll == 0{
             return true
         }
         return false
     }
    
     var scroll : CGFloat = 0.0
     
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
         scroll = scrollView.contentOffset.y
     }
    
    
    func close(compeletion: (()->())? = nil) {
        delegate?.didDismissViewController()
        UIView.animate(withDuration: 0.25, animations: {
            var frm = self.vuContain.frame
            frm.origin.y = UIScreen.main.bounds.size.height
            self.vuContain.frame = frm
        }) { (com) in
            self.dismiss(animated: false, completion: nil)
            compeletion?()
        }

    }

}
