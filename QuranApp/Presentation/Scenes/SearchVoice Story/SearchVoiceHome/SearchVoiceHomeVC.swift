//
//  SearchVoiceHomeVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import AVFoundation
import ZVProgressHUD

class SearchVoiceHomeVC: BaseViewController {
    
    var isRecord = false
    
    var speech:DSpeechRecognition!
    
    var textSearch: String?

   
    //
    
    var pulseEffect: LFTPulseAnimation!
    
    
    @IBOutlet weak var vuKeys: UIView!
    @IBOutlet weak var vuRecord: UIView!
    @IBOutlet weak var vuContain: UIView!
    

    @IBAction func keysClicked(_ sender: Any) {
        UIImpactFeedbackGenerator.init(style: .light).impactOccurred()
        let vc = VoiceKeysVC.createVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func touchButtonDown(_ sender: Any) {
        //start record
        speech = DSpeechRecognition(local: "ar")
        speech.setupSpeech()
           if speech.isRunning == true {
               return
           }
        
        self.speech.startRecording { [weak self] (text) in
            guard let self = self else { return }
            self.textSearch = text
        }
        AudioServicesPlaySystemSound(1113)
        self.pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius:20, position:self.vuRecord.center)
        self.pulseEffect.radius = self.vuContain.bounds.width/2
        self.pulseEffect.backgroundColor = UIColor.c1.cgColor
        self.vuContain.layer.insertSublayer(self.pulseEffect, below: self.vuRecord.layer)

        
    }
    
    @IBAction func recordClicked(_ sender: Any) {
        //finish record
        if speech.isRunning == false {
            return
        }
         ProgressHUD.shared.show()
         self.pulseEffect.removeFromSuperlayer()
         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
             self.speech.stopRecording()
             AudioServicesPlaySystemSound(1114)
             ProgressHUD.shared.dismiss()
             let ayah = SearchVoicePresenter.getAyahByVoiceText(text: self.textSearch)
             print(self.textSearch)
             if let ayah = ayah {
                self.tabBarController?.selectedIndex = 0
                 AppFactory.homeVC?.search(ayah: ayah)
             }else {
                AlertClass2.ShowErrorStatusBar(vc: self, message: "search result not found".localized)
            }
            self.speech = nil
         }

        
        DispatchQueue.main.async {
            if self.isRecord {
                AudioServicesPlaySystemSound(1114)
                self.pulseEffect.removeFromSuperlayer()
            }else {
            }
            self.isRecord = !self.isRecord
        }
    }
}


extension SearchVoiceHomeVC {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
}


extension SearchVoiceHomeVC {

    func setupUI() {
        self.setupColoredBackground()
        vuKeys.bor(radius: 12, color: .clear)
        vuKeys.layer.masksToBounds = true
        DispatchQueue.main.async {
            self.vuRecord.bor(radius: self.vuRecord.frame.width / 2, color: .c1, w: 10)
        }
    }
    
}

extension SearchVoiceHomeVC {

    static func createVC() -> SearchVoiceHomeVC {
        let vc = UIStoryboard.init(name: "SearchVoice", bundle: nil).instantiateViewController(withIdentifier: "SearchVoiceHomeVC") as! SearchVoiceHomeVC
        vc.modalPresentationStyle = .fullScreen
        return vc
    }

    
}
