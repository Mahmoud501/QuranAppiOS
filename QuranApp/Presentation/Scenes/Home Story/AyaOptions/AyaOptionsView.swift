//
//  AyaOptionsView.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/17/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import DownloadButton
import StepSlider

class AyaOptionsView: UIView {
    
    //variables
    var hideWriteView: UIView?
    var vc: UIViewController!
    var downloadTimer: Timer?
    var selectedAyat: Dictionary<String, CAyatModel>? {
        didSet {
            self.player.cancelDownload()
            self.player.cancelPlayer()
            self.btnPlay.setImage(UIImage.init(named: "play")!, for: .normal)
            self.lblPlay.text = "Play".localized
            self.player.resetParamerter()
            self.orderAyat = selectedAyat?.sorted(by: { (a1, a2) -> Bool in
                return Int(a1.value.id ?? "0")! < Int(a2.value.id ?? "0")!
            }).map{ $0.value }
            self.vuStackPlay.alpha = 1
            self.vuPlay.state = .startDownload
            if (self.orderAyat?.count ?? 0) != 0 {
                self.blockStepper = true
                self.myStepSlider.index = 0
                self.blockStepper = false
                let count = UInt(self.orderAyat?.count ?? 1)
                if count <= 1 {
                    self.blockStepper = true
                    self.myStepSlider.maxCount = 2
                    self.blockStepper = false
                    self.myStepSlider.isUserInteractionEnabled = false
                }else {
                    self.myStepSlider.isUserInteractionEnabled = true
                    self.blockStepper = true
                    self.myStepSlider.maxCount = count
                    self.blockStepper = false
                }
            }
        }
    }
    
    var memorizedAyat: (()->())?
    var colorAyat: (()->())?
    var willPlayAyah: ((CAyatModel?, Bool?) -> ())?    
    var player = PlayerAyat()
    var orderAyat: [CAyatModel]?
    var blockStepper = false
    var isdrag = false
    var currentPlayAyahIndex: Int?
    
    //outlet
    @IBOutlet weak var myStepSlider: StepSlider!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnPlay: UIButton!//play ,Pause
    @IBOutlet weak var vuPlay: PKDownloadButton!
    @IBOutlet weak var lblPlay: UILabel!
    @IBOutlet weak var vuStackPlay: UIStackView!
    @IBOutlet weak var vuStackTafseer: UIStackView!
    @IBOutlet weak var vuStackTest: UIStackView!
    @IBOutlet weak var vuStackColor: UIStackView!
    @IBOutlet weak var vuStackClear: UIStackView!
    @IBOutlet weak var bottomStack: NSLayoutConstraint!
    
    @IBAction func touchDown(_ sender: Any) {
        isdrag = true
    }
    
    
    @IBAction func dragSider(_ sender: Any) {
        isdrag = true
    }
    
    @IBAction func touchupInsideSlider(_ sender: Any) {
        isdrag = false
        changeSlider()
    }
    
    
    @IBAction func valueChanged(_ sender: Any) {
        if self.blockStepper { return }
        if self.isdrag { return }
        self.changeSlider()

    }
    
    
    func changeSlider() {
        if self.vuPlay.state == .pending { return }
        if self.vuPlay.state == .downloading { return }
        self.vuPlay.state = .pending
        self.vuStackPlay.alpha = 0
        self.myStepSlider.isUserInteractionEnabled = false
        self.player.seekTo(index: Int(self.myStepSlider?.index ?? 0), ayat: self.orderAyat, withDown: true)
    }
    // init
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         commit()
     }
       
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         commit()
     }

     func commit(){
         Bundle.main.loadNibNamed("AyaOptionsView", owner: self, options: nil)
         addSubview(contentView)
         contentView.frame = self.bounds
         contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
         setupUI()
     }
    
    
    
    // setupUI
    
    func setupUI() {
        setupPlayer()
        self.vuPlay.delegate = self
        setupAction()
        self.vuPlay.setupButton(color: UIColor.c4 , radiusPrecent: 0.25)
        DispatchQueue.main.async {
            self.bottomStack.constant =  self.bottomStack.constant + NSLayoutConstraint.bottomSafe
            for item in self.constraints {
                if item.firstAttribute == .height && item.constant > 0 {
                    item.constant = item.constant + NSLayoutConstraint.bottomSafe
                }
            }
        }
        
    }
    
    
//    func setupConstraint(vu: UIView) {
//        vu.addSubview(self)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .trailing, relatedBy: .equal, toItem: vu, attribute: .trailing, multiplier: 1, constant: 0))
//        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .leading, relatedBy: .equal, toItem: vu, attribute: .leading, multiplier: 1, constant: 0))
//        var bottom: CGFloat? = 0
//        if #available(iOS 11.0, *) {
//            let window = UIApplication.shared.keyWindow
//            bottom = window?.safeAreaInsets.bottom
//        }
//        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50 + (bottom ?? 0)))
//        vu.addConstraint(NSLayoutConstraint(item: self as Any, attribute: .bottom, relatedBy: .equal, toItem: vu, attribute: .bottom, multiplier: 1, constant: 0 ))
//    }

    
}

extension AyaOptionsView: PKDownloadButtonDelegate {
    
    func downloadButtonTapped(_ downloadButton: PKDownloadButton!, currentState state: PKDownloadButtonState) {
        self.playAyat()
    }
    
    // setupActions
    
    func setupAction() {
        
         let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tafseer))
        self.vuStackTafseer.addGestureRecognizer(tap2)

        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(test))
        self.vuStackTest.addGestureRecognizer(tap3)

        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(color))
        self.vuStackColor.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer.init(target: self, action: #selector(clear))
        self.vuStackClear.addGestureRecognizer(tap5)
    }
    
    
    //actions
    
    
    
    
    @objc func tafseer() {
        
        UIView.animate(withDuration: 0.5) {
            self.vc.view.alpha = 0.6
        }
        let tafseerVC = TafseerPopupMenuRouter.createVC( delegate: self, orderAyat: self.orderAyat) as? TafseerPopupMenu
        print(self.currentPlayAyahIndex)
        tafseerVC?.startIndex = self.currentPlayAyahIndex ?? 0
        vc.present(tafseerVC!, animated: true, completion: nil)
        
        
    }
    
    
    
    @objc func test() {
        UIView.animate(withDuration: 0.5) {
            self.vc.view.alpha = 0.6
        }
        let vc2 = TestPopupMenuRouter.createVC(delegate: self)
        vc.present(vc2, animated: true, completion: nil)
    }
    
    
    
    @objc func color() {
      
        let alertContoller = UIAlertController.init(title: "Color".localized, message: "messageColor".localized, preferredStyle: UIAlertController.Style.actionSheet)
        
        let action1 = UIAlertAction.init(title: "Need Review".localized, style: UIAlertAction.Style.default) { (alert) in
            self.setColorToAyat(index: "0")
        }
        let action2 = UIAlertAction.init(title: "Always Forget Something".localized, style: UIAlertAction.Style.default) { (alert) in
            self.setColorToAyat(index: "1")
        }
        let action3 = UIAlertAction.init(title: "Always Wrong".localized, style: UIAlertAction.Style.default) { (alert) in
            self.setColorToAyat(index: "2")
        }
        let action4 = UIAlertAction.init(title: "Clear".localized, style: UIAlertAction.Style.default) { (alert) in
            self.setColorToAyat(index: "")
        }
        let action5 = UIAlertAction.init(title: "Cancel".localized, style: UIAlertAction.Style.cancel) { (alert) in
            
        }
        
        //colors
        
        action1.setValue(UIColor.blue, forKey: "titleTextColor")
        action2.setValue(UIColor.systemYellow, forKey: "titleTextColor")
        action3.setValue(UIColor.red, forKey: "titleTextColor")
        action4.setValue(UIColor.black, forKey: "titleTextColor")
        
        
        //
        
        alertContoller.addAction(action1)
        alertContoller.addAction(action2)
        alertContoller.addAction(action3)
        alertContoller.addAction(action4)
        alertContoller.addAction(action5)
        
        alertContoller.modalPresentationStyle = .popover
              if let popoverController = alertContoller.popoverPresentationController {
                  popoverController.sourceView = vc.view //to set the source of your alert
                  popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                  popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
              }
        vc.present(alertContoller, animated: true, completion: nil)
        
    }
    
    
    
    @objc func clear() {
        let alertContoller = UIAlertController.init(title: "Memorized Ayah".localized, message: "messageMemorized".localized, preferredStyle: UIAlertController.Style.actionSheet)
        
        let action1 = UIAlertAction.init(title: "Yes,I Memorized".localized, style: UIAlertAction.Style.default) { (alert) in
            self.isMemorizeAyat(status: true)
        }
        let action2 = UIAlertAction.init(title: "No, Not Memorized Yet".localized, style: UIAlertAction.Style.default) { (alert) in
            self.isMemorizeAyat(status: false)
        }
        let action3 = UIAlertAction.init(title: "Cancel".localized, style: UIAlertAction.Style.cancel) { (alert) in
        }
        action2.setValue(UIColor.red, forKey: "titleTextColor")
        alertContoller.addAction(action1)
        alertContoller.addAction(action2)
        alertContoller.addAction(action3)
        alertContoller.modalPresentationStyle = .popover
                     if let popoverController = alertContoller.popoverPresentationController {
                         popoverController.sourceView = vc.view //to set the source of your alert
                         popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
                         popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
                     }
        vc.present(alertContoller, animated: true, completion: nil)

    }
    
    
}

extension AyaOptionsView: TestPopupMenuDelegate {
    
    func didTapVoice() {
        player.pause()
        let vc2 = VoiceTestVC.createVC(parentView: vc.view)
        vc2.ayat = self.orderAyat
        vc2.all_ayat = self.orderAyat
        vc.present(vc2, animated: true, completion: nil)

    }
    
    func didTapWriteTest() {
        let vc2 = WriteTestVC.createVC(parentView: vc.view, hideView: self.hideWriteView)
        vc2.orderAyat = self.orderAyat
        vc.present(vc2, animated: true, completion: nil)

     }
    
    func didTapWordTest() {
        let vc2 = WordTestVC.createVC()
        vc.navigationController?.pushViewController(vc2, animated: true)
    }
    
    func didTapSortTest() {
        let vc2 = SortTestVC.createVC()
        vc2.ayat = self.orderAyat
        vc.present(vc2, animated: true, completion: nil)
    }
    
    func didTapCompleteAyatTest() {
        let vc2 = CompleteVC.createVC()
        vc2.ayat = self.orderAyat
        vc.navigationController?.pushViewController(vc2, animated: true)
    }
    
    func didDismissViewController() {
         UIView.animate(withDuration: 0.5) {
            self.vc.view.alpha = 1
        }
    }
    
    func didTapClearWrongWrite() {
        for item in self.orderAyat ?? [] {
            item.error = ""
            item.simple_error = ""
        }
        CoreDataRepository.save()
        AppFactory.homeVC?.TVAyat.reloadData()
    }
    
    
}


extension AyaOptionsView: TafseerPopupMenuDelegate {
    
    func didDismissTafseerController() {
        UIView.animate(withDuration: 0.5) {
            self.vc.view.alpha = 1
        }
    }
    
    
}


