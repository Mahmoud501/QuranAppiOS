//
//  VoiceReciteTest.swift
//  QuranApp
//
//  Created by Mahmoud Zaki on 19/02/2022.
//  Copyright © 2022 Wakeb. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceReciteTestVC: UIViewController {
    
    var ayat: [CAyatModel]?
    var count = 3
    var timer: Timer?
    var timerUpdateRecord: Timer?
    var timerDelayVoice: Timer?

    var trackCurrentAyah = 0
    var lastAyahId: String?
    //
    var pulseEffectView: LFTPulseAnimation!
    var speech:DSpeechRecognition!
    var textSearch: String?
    var timerDelayNow: Double = 0
    var current: Double = 0
    let delayTime: Double = 0.2

    //
    @IBOutlet weak var vuContent: UIView!
    @IBOutlet weak var vuClose: UIView!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var vuSkip: UIView!
    
    
    //
    
    
    @IBAction func backClicked(_ sender: Any) {
        self.back()
        //        let correct = WriteTestVC.checkText(ayah: ayat?[0], testString: r)
        //        print(correct!.2)
        //        print(correct!.0)
    }
    
    @IBAction func recordClicked(_ sender: Any) {
        
    }
    @IBAction func skipClicked(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.progress()
        }
    }
    
    
}

extension VoiceReciteTestVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AlertClass2.showMessageInfo(vc: self, title: "تنبيه", message:
                                        "يمكنك ضغط زرار تخطي اذا لم ينجح الجهاز في تحديد صوتك لاية محددة واذا هناك كلمات لم تحدد جاوزها وتخطها واستمر بالتسميع"
                                    , infoTap: nil)
        self.setupUI()
        self.startAfter(count: self.count)
        
    }
    
}

extension VoiceReciteTestVC {
    
    func setupUI() {
        DispatchQueue.main.async {
            self.vuClose.setCirleCornerRadius()
            self.vuSkip.setCirleCornerRadius()
        }
        UIView.animate(withDuration: 0.25) {
            self.vuContent.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7)
        }
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        timerDelayVoice = Timer.scheduledTimer(timeInterval: delayTime, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        speech = DSpeechRecognition(local: "ar")
        speech.setupSpeech()
        
    }
    
    func startAfter(count: Int) {
        if pulseEffectView != nil {
            pulseEffectView.removeFromSuperlayer()
        }
        AudioServicesPlaySystemSound(1114)
        self.count = count
        self.vuClose.alpha = 0
        self.vuSkip.alpha = 0
        self.btnRecord.alpha = 0
        self.lblText.textColor = .red
        self.lblText.font = UIFont.init(name: self.lblText.font.fontName, size: 55)
        self.lblText.text = count.description
    }
    
    
    func startTimerUpdateRecord() {
        timerUpdateRecord = Timer.scheduledTimer(timeInterval: 40, target: self, selector: #selector(updateRecord), userInfo: nil, repeats: true)
    }
    
    func addAffect(to button: UIView, color: UIColor) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        pulseEffectView = LFTPulseAnimation(repeatCount: Float.infinity, radius: 3, position: button.center)
        pulseEffectView.radius = view.bounds.width/5
        pulseEffectView.backgroundColor = color.cgColor
        button.superview?.layer.insertSublayer(pulseEffectView, below: button.layer)
    }
    
    @objc func update() {
        if(count > 0) {
            count = count - 1
            lblText.text = String(count)
        }else {
            AppFactory.homeVC?.scrollToAyah(ayah: self.ayat?[0], animation: true)
            self.lblText.text = ""
            timer?.invalidate()
            timer = nil
            AlertClass2.vibrate()
            self.vuClose.alpha = 1
            self.btnRecord.alpha = 1
            self.vuSkip.alpha = 1
            self.lblText.textColor = .white
            self.lblText.font = UIFont.init(name: self.lblText.font.fontName, size: 15)
            self.addAffect(to: self.btnRecord, color: .red)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.startRecord()
//                self.startTimerUpdateRecord()
            }
        }
    }
    
    @objc func updateTime() {
        timerDelayNow = timerDelayNow + delayTime
    }
    
    @objc func updateRecord() {
        if (self.speech != nil) {
            self.speech.stopRecording()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.startRecord()
        }

    }
    
    func back() {
        self.timerDelayVoice?.invalidate()
        self.timerDelayVoice = nil
        self.timer?.invalidate()
        self.timer = nil
        self.timerUpdateRecord?.invalidate()
        self.timerUpdateRecord = nil
        if(self.speech != nil ) {
            self.speech.stopRecording()
        }
        self.speech = nil
        self.dismiss(animated: true)
    }
    
    func finishSuccess() {
        self.lblText.textColor = .green
        self.lblText.font = UIFont.init(name: self.lblText.font.fontName, size: 55)
        self.lblText.text = "تم بحمد الله"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.back()
        }
        
    }
}

extension VoiceReciteTestVC {
    
    func startRecord() {
        
        self.speech.startRecording { [weak self] (text) in
            guard let self = self else { return }
            if var text = text {
//                if self.trackCurrentAyah < (self.ayat?.count ?? 0) {
//                    let ayah = self.ayat?[self.trackCurrentAyah]
//                    self.textSearch = text
//                    self.lblText.text = text
//                    if(text.ayahFilter2.ayahFilter.contains(ayah!.simple_desc!.ayahFilter2.ayahFilter)) {
//                        if(self.lastAyahId != ayah?.id) {
//                            self.speech.stopRecording()

                //            self.lastAyahId = ayah?.id
//                            self.textSearch = ""
//                            self.lblText.text = ""
//                            if (self.trackCurrentAyah) < (self.ayat?.count ?? 0) {
//                                AppFactory.homeVC?.scrollToAyah(ayah: self.ayat?[self.trackCurrentAyah], animation: true)
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    self.startRecord()
//                                }
//                            }else {
//                                self.finishSuccess()
//                            }
//                        }
//                    }
//                }
                if self.trackCurrentAyah < (self.ayat?.count ?? 0) {
                   let ayah = self.ayat?[self.trackCurrentAyah]
                    if self.timerDelayNow - self.current  > self.delayTime {
                        print(self.current - self.timerDelayNow)
                        let result = WriteTestVC.checkVoiceText(ayah: ayah, testString: text, lastIndex: (self.lblText.text?.split(separator: " ").count ?? 1) - 1)
                        self.current = self.timerDelayNow
                        if let result = result {
                            self.lblText.text = result.0
                            if(result.1 == true) {
                                self.progress()
                            }
                        }
                    }
                   
                }

                
            }
        }
    }
    
    func progress() {
        self.trackCurrentAyah = self.trackCurrentAyah + 1
        if (self.trackCurrentAyah) < (self.ayat?.count ?? 0) {
            if self.speech != nil {
                self.speech.stopRecording()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.lblText.text = ""
                self.startRecord()
            }
        AppFactory.homeVC?.scrollToAyah(ayah: self.ayat?[self.trackCurrentAyah], animation: true)
        }else {
            if self.speech != nil {
                self.speech.stopRecording()
            }
            self.finishSuccess()
        }
    }
    
}


extension VoiceReciteTestVC {
    
    static func createVC() -> VoiceReciteTestVC {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "VoiceReciteTestVC") as! VoiceReciteTestVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        return vc
    }
    
}

extension String {
    func removeNilCharacters() -> String {
        return self.replacingOccurrences(of: "\u{fffc}", with: "", options: String.CompareOptions.literal, range: nil)
    }
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
