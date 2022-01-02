//
//  VoiceTestVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/20/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import AVFoundation
import DropDown

class VoiceTestVC: BaseViewController {
   
    var all_ayat: [CAyatModel]?
    var ayat: [CAyatModel]?
    
    //
    
    var p = PlayerAyat.init()
    var recordClass = RecordClass()
    var isRecord = false
    var playType = 0 // 0 , none , 1 -> Reciter , 2-> profile , 3 -> Both
    
    let ayaDropDown = DropDown()
    let darkred = UIColor.init(displayP3Red: 195/255, green: 55/255, blue: 55/255, alpha: 1)
    var parentView: UIView?
    var initialTouchPoint: CGPoint = CGPoint.init(x: 0, y: 0)
    var scroll : CGFloat = 0.0
    var pulseEffectRecord: LFTPulseAnimation!
    var pulseEffectView: LFTPulseAnimation!

    @IBOutlet weak var btnAyahDesc: UIButton!
    @IBOutlet weak var imgReciter: UIImageView!
    @IBOutlet weak var activityReciter: UIActivityIndicatorView!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var vuReciter: UIView!
    @IBOutlet weak var vuProfile: UIView!
    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var vuAyaNum: UIView!
    @IBOutlet weak var lblAyaNum: UILabel!
    @IBOutlet weak var vuResult: UIStackView!
    var i = 0
    
    @IBAction func reciterClicked(_ sender: Any) {
        DispatchQueue.main.async {
            if self.p.isPlaying == false {
            if self.p.isDownloadingAyat == false {
                if self.p.isDownloaedAyat == false {
                    self.activityReciter.startAnimating()
                }
                self.p.genralPlay(ayat: self.ayat, index: 0)
            }
        }else {
            self.p.pause()
            }
        }
    }
    
    @IBAction func profileClicked(_ sender: Any) {
        if let audio = self.recordClass.audioFile {
            DispatchQueue.main.async {
                if self.recordClass.isPlaying() {
                    self.recordClass.stopPlay()
                 }else {
                    self.recordClass.loadAudio(url: audio.url)
                    self.recordClass.PlayRecord()
                 }
            }
         }

        
    }
    
    @IBAction func mergeClicked(_ sender: Any) {
        
    }
        
    @IBAction func recordClicked(_ sender: Any) {
        if isRecord == false {
            self.startRecord()

        }else {
            self.recordClass.stopRecording()
            isRecord = false
            AudioServicesPlaySystemSound(1114)
            pulseEffectRecord.removeFromSuperlayer()
            UIView.animate(withDuration: 0.5) {
                self.vuResult.alpha = 1
            }
            vuAyaNum.isUserInteractionEnabled = true
        }
    }
        
    func startRecord() {
        self.p.pause()
        self.recordClass.stopPlay()
        recordClass = RecordClass()
        vuAyaNum.isUserInteractionEnabled = false
        self.recordClass.startRecording()
        isRecord = true
        pulseEffectRecord = LFTPulseAnimation(repeatCount: Float.infinity, radius: 3, position: btnRecord.center)
        pulseEffectRecord.radius = view.bounds.width/4
        pulseEffectRecord.backgroundColor = UIColor.red.cgColor
        btnRecord.superview?.layer.insertSublayer(pulseEffectRecord, below: btnRecord.layer)
        vuResult.alpha = 0
    }
    
    @IBAction func shareClicked(_ sender: Any) {
        if let fileURL = self.recordClass.audioFile?.url {
            // Create the Array which includes the files you want to share
            var filesToShare = [Any]()

            // Add the path of the file to the Array
            filesToShare.append(fileURL)

            // Make the activityViewContoller which shows the share-view
            let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)

            // Show the share-view
            self.present(activityViewController, animated: true, completion: nil)

        }


    }
        
    @IBAction func backClicked(_ sender: Any) {
        close()
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
                self.close()
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }
    
    
    @IBAction func ayaNumClicked(_ sender: Any) {
        ayaDropDown.show()
    }
}


extension VoiceTestVC {
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           UIView.animate(withDuration: 0.5) {
               self.parentView?.alpha = 0.6
           }
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        p.willStartPlay = { [weak self] (index) in
            self?.activityReciter.stopAnimating()
        }
        self.btnRecord.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startRecord()
            self.btnRecord.isUserInteractionEnabled = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.btnShare.setupGradientColor()
    }
}


extension VoiceTestVC {
    
    func setupUI() {
        vuResult.alpha = 0
        self.view.backgroundColor = .clear
        vuContain.layer.cornerRadius = 10
        vuContain.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vuContain.layer.masksToBounds = true
        btnShare.bor(radius: 13, color: .clear)
        btnShare.layer.masksToBounds = true
        vuAyaNum.bor(radius: vuAyaNum.frame.height / 2, color: .clear)
        var arr = self.ayat?.map { ($0.surha?.name_ar ?? "") + "(" + $0.sort.description  + ")"}
        arr?.insert("All".localized, at: 0)
        self.lblAyaNum.text = "All".localized
        self.btnAyahDesc.setTitle("All".localized, for: .normal)
        setupDropDown(vu: vuAyaNum, dropdown: ayaDropDown, source: arr ?? [], action: "ayaNumClicked:")
        ayaDropDown.selectionAction = { [weak self] (index, item) in
            guard let self = self else { return }
            if index == 0 {
                self.btnAyahDesc.setTitle("All".localized, for: .normal)
                self.lblAyaNum.text = "All".localized
                self.ayat = self.all_ayat
            }else {
                let ayah = self.all_ayat![index - 1]
                self.ayat = [ayah]
                self.btnAyahDesc.setTitle(ayah.desc, for: .normal)
                self.lblAyaNum.text = "Aya Num".localized + ": " + item
            }
            self.startRecord()

        }
        vuReciter.bor(radius: 8, color: .clear)
        vuProfile.bor(radius: 8, color: .clear)
        let imgName = AppFactory.currentReciter?.image_path ?? ""
        self.imgReciter.image = UIImage.init(named: imgName)
    }
    
    func close(compeletion: (()->())? = nil) {
        self.recordClass.stopPlay()
        self.recordClass.stopRecording()
        UIView.animate(withDuration: 0.5) {
            self.parentView?.alpha = 1
        }
        UIView.animate(withDuration: 0.25, animations: {
            var frm = self.vuContain.frame
            frm.origin.y = UIScreen.main.bounds.size.height
            self.vuContain.frame = frm
        }) { (com) in
            self.dismiss(animated: false, completion: nil)
            compeletion?()
        }

      }
    
   

    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
         if scroll == 0{
             return true
         }
         return false
     }
    
     
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
         NSLog("Table view scroll detected at offset: %f", scrollView.contentOffset.y)
         scroll = scrollView.contentOffset.y
     }
    
    
    func playreflect(type: Int) {
        if pulseEffectView != nil {
            pulseEffectView.removeFromSuperlayer()
        }
        if type == playType {
            playType = 0
        }else if type == 1 {
            playType = 1
            addAffect(to: vuReciter, color: .c5)
        }else if type == 2 {
            playType = 2
            addAffect(to: vuProfile, color: darkred)
        }else if type == 3 {
            playType = 3
        }
    }
    
    func addAffect(to button: UIView, color: UIColor) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        pulseEffectView = LFTPulseAnimation(repeatCount: Float.infinity, radius: 3, position: button.center)
        pulseEffectView.radius = view.bounds.width/5
        pulseEffectView.backgroundColor = color.cgColor
        button.superview?.layer.insertSublayer(pulseEffectView, below: button.layer)
    }
    
}


extension VoiceTestVC {
    
    static func createVC(parentView: UIView?) -> VoiceTestVC {
          let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "VoiceTestVC") as! VoiceTestVC
          vc.modalPresentationStyle = .overFullScreen
          vc.parentView = parentView
          return vc
      }
    
}


