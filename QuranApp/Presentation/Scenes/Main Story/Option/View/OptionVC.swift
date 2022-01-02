//
//  OptionVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import TransitionButton
import DropDown

class OptionVC: BaseViewController {

    //
    var presenter: OptionPresenter?
    let langDropDown = DropDown()
        
    ///
    
    @IBOutlet weak var txtPhone: ZDSkyTextField!
    @IBOutlet weak var txtLocation: ZDSkyTextField!
    @IBOutlet weak var txtName: ZDSkyTextField!
    @IBOutlet weak var txtAge: ZDSkyTextField!
    @IBOutlet weak var txtLang: ZDSkyTextField!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var btnSave: TransitionButton!
    
    
    @IBAction func skipClicked(_ sender: Any) {
        let user = UserModel()
        user.age = "0"
        user.name = ""
        presenter?.cacheUser(user: user)
        next()
    }
    
    @IBAction func saveClicked(_ sender: Any) {
        btnSave.startAnimation()
        let user = UserModel()
        user.age = txtAge.text!
        user.location = txtLocation.text
        user.phone = txtPhone.text
        user.name = txtName.text        
        presenter?.register(user: user)
    }
    
    @IBAction func langClicked(_ sender: Any) {
        langDropDown.show()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnSave.setBackgroundLight()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = OptionPresenter.init(registerView: self)
        setupUI()
   }
    
    func setupUI() {
        btnSave.spinnerColor = UIColor.c4
        setupColoredBackground()
        vuContain.bor(radius: 13, color: .clear)
        self.btnSave.cornerRadius = 13        
        txtName.placeHolder = "What should I call you?".localized
        txtName.setCustomStyle =  true
        txtName.iconData = UIImage.init(named: "edit")
        
        txtPhone.placeHolder = "Phone".localized
        txtPhone.setCustomStyle =  true
        txtPhone.keyboardType = .phonePad

        txtLocation.placeHolder = "Country".localized
        txtLocation.setCustomStyle =  true

        
        txtAge.placeHolder = "Age".localized
        txtAge.setCustomStyle =  true
        txtAge.keyboardType = .numberPad
        txtAge.iconData = UIImage.init(named: "edit")
        txtLang.placeHolder = "Favorite Language".localized
        txtLang.superview?.isHidden = true
        txtLang.iconData = UIImage.init(named: "arrow-down")
        txtLang.setCustomStyle =  true
        setupDropDown(txtLang.textField, vu: txtLang, dropdown: langDropDown, source: ["عربي" , "English"], action: "langClicked:")
        langDropDown.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            self.txtLang.text = item
        }
    }


    func next() {
        let vc = SelectReciterVC.createVC()
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }

}


extension OptionVC {
    
    static func createVC() -> OptionVC {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OptionVC") as! OptionVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
}

extension OptionVC: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
}


extension OptionVC: UIViewControllerAnimatedTransitioning {
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        var finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        finalFrameForVC.origin.y = UIScreen.main.bounds.size.height * -1
        let containerView = transitionContext.containerView
        toViewController.view.frame = finalFrameForVC
        toViewController.view.alpha = 1
        
        containerView.addSubview(toViewController.view)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            var newfromFrame = fromViewController.view.frame
            newfromFrame.origin.y = UIScreen.main.bounds.size.height
            fromViewController.view.frame = newfromFrame
            
            var newtoFrame = toViewController.view.frame
            newtoFrame.origin.y = 0
            toViewController.view.frame = newtoFrame

            }, completion: {
                finished in
                transitionContext.completeTransition(true)
        })

    }

}

