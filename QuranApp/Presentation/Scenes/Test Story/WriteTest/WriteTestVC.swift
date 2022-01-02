//
//  WriteTestVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/20/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit

class WriteTestVC: UIViewController {

    var orderAyat: [CAyatModel]?
    var type: Int = 1 // type = 1 mean test write only from home , 2 = mean test write from sub view like complete ayats
    var result: ((String?)->())?
    
    //
    
    var hideView: UIView?
    var parentView: UIView?
    
    //
    
    @IBOutlet weak var txtResult: UITextView!
    @IBOutlet weak var txtText: UITextView!
    @IBOutlet weak var vuSend: UIView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var txtH: NSLayoutConstraint!
    @IBOutlet weak var vuContain: UIStackView!
    @IBOutlet weak var vuResult: UIView!
    
    @IBAction func sendClicked(_ sender: Any) {
        if txtText.text.replacingOccurrences(of: " ", with: "").isEmpty == true {
            return
        }
        self.view.endEditing(true)
        let tuple = testAll(withMark: false)
        if tuple?.2 == true {
            if type == 1 {
                AlertClass2.ShowSuccessMessage(vc: nil, message: "test.m1".localized, title: "Write Test Result".localized, interact: true)
            }
            result?(nil)
            saveAndBack()
        }else {
            result?(tuple?.0)
            if type == 1 {
                self.vuContain.alpha = 0
                self.txtResult.text = tuple?.0
                self.txtResult.attributedText = String.colorText(text: self.txtResult.text!, searchText: ["(", ")"])
                self.txtResult.textAlignment = .right
                self.txtResult.font = UIFont.init(name: "Cairo-Regular", size: 18)
                self.txtResult.setNeedsDisplay()
                self.vuResult.alpha = 1
            }else{
                back()
            }
            
        }
        
    }
    
    
    @IBAction func doneClicked(_ sender: Any) {
        back()
    }
    
    @IBAction func showinHomeClicked(_ sender: Any) {
        saveAndBack()
    }
    
    func saveAndBack() {
        _ = testAll(withMark: true)
        CoreDataRepository.save()
        AppFactory.homeVC?.TVAyat.reloadData()
        back()
    }
    
    
    @IBAction func back(_ sender: Any) {
        back()
    }
    
    
    func back() {
        UIView.animate(withDuration: 0.5) {
            self.parentView?.alpha = 1
            self.hideView?.alpha = 1
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            var frm = self.vuContain.frame
            frm.origin.y = UIScreen.main.bounds.size.height
            self.vuContain.frame = frm
        }) { (com) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    
    static func checkText(ayah: CAyatModel?, testString: String) -> (String, String, Bool)? {
        if testString.isEmpty == false {
            var testString = testString.ayahFilter2
            let correctText = (ayah?.simple_desc ?? "").ayahFilter2
            let correctText0 = (ayah?.simple_desc ?? "")
            let correctText2 = ayah?.desc ?? ""
            var correctWords0 = correctText0.split(separator: " ")
            var correctWords = correctText.split(separator: " ")
            var correctWords2 = (ayah?.desc ?? "").split(separator: " ")
            var testWords = testString.split(separator: " ")
            testWords = testWords.filter { $0 != " " }
            testString = testWords.joined(separator: " ")
            if correctText.ayahFilter == testString.ayahFilter {
                return (correctText, correctText2, true)
            }
            var lastPointer = 0
            for i in 0 ..< testWords.count {
                var isStartError = false
                let count = lastPointer + 3
                if lastPointer >= correctWords.count {
                        break
                }                
                for j in lastPointer ... count {
                    if j < correctWords.count {
                        lastPointer = j + 1
                        if testWords[i] == correctWords[j] {
                            if isStartError == true {
                                correctWords0[j - 1] = correctWords0[j - 1].description + ")"
                                correctWords[j - 1] = correctWords[j - 1].description + ")"
                                correctWords2[j - 1] = correctWords2[j - 1].description + ")"
                            }
                            break
                        }else {
                            if isStartError == false {
                                correctWords0[j] = "(" + correctWords0[j].description
                                correctWords[j] = "(" + correctWords[j].description
                                correctWords2[j] = "(" + correctWords2[j].description
                                isStartError = true
                            }
                            if  (j >= correctWords.count - 1) || j == count {
                                lastPointer = (count - 3)
                                correctWords0[lastPointer] = correctWords0[lastPointer].description  + " - " + testWords[i].description + ")"
                                correctWords[lastPointer] = correctWords[lastPointer].description  + " - " + testWords[i].description + ")"
                                correctWords2[lastPointer] = correctWords2[lastPointer].description + " - " + testWords[i].description + ")"
                                lastPointer += 1
                            }
                        }
                    }
                }
            }
            if (correctWords.count > lastPointer) {
                var lenthTest = lastPointer
                let lastCorrect = correctWords.count - 1
                if lenthTest >= correctWords.count {
                   lenthTest = correctWords.count - 1
                }
                correctWords0[lenthTest] = "(" + correctWords0[lenthTest].description
                correctWords[lenthTest] = "(" + correctWords[lenthTest].description
                correctWords2[lenthTest] = "(" + correctWords2[lenthTest].description
                
                correctWords0[lastCorrect] = correctWords0[lastCorrect].description + ")"
                correctWords[lastCorrect] = correctWords[lastCorrect].description + ")"
                correctWords2[lastCorrect] = correctWords2[lastCorrect].description + ")"
            }else {
            }
            let text0 = correctWords0.joined(separator: " ")
            let text = correctWords.joined(separator: " ")
            let text2 = correctWords2.joined(separator: " ")

            return (text0, text2, false)
        }
        return nil
    }
    
    
    func test() {
            let testarr = [
            "بسم الله",
            "بسم",
            "بسم الرحمن",
            "الرحمن الرحيم",
            "بسم الرحيم",
            "الله الرحيم",
            "الرحيم الرحمن",
            "بسم الله الرحمن",
            
            "بسم الله الرحمن الرحيم",
            "بسم الله الرحيم",
            "بسم الله الرحمن",
            "بسمم الله الرحمن الرحيم",
            "بسمم الرحمن الرحميم",
            "بسمم الله الرحمن",
        "بسمم الله الرحيم",
        "بسمم الله الرحممن الرحيم",
        "سمم الله الرحمن الرحييم",
            ]
            
            let testarr2 = [
            "بسم اللله الرحممن الرحيم",
            "بسمم الرحييم",
            "بسبسبس",
            "لا اله الا الله سيدنا محمد رسول الله والله اكبر",
            "بسم الله الرحمن الرحيييم",
            "بسمم اللله الرحممن الرحييم",
            "بسم اللله",
            "بسم الرحممن الرحيم ",
            "الله اكبر",
            "بسم الله اكبر",
            
            ]
            
            let repo = CoreDataRepository<CAyatModel>.init()
            let ayah = repo.getAll()?.first(where: { $0.id == "1"})

            for item in testarr2 {
                let tuple =   WriteTestVC.checkText(ayah: ayah, testString: item)
                print(tuple?.1 ?? "" )
            }

    }
}


extension WriteTestVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.parentView?.alpha = 0.6
            self.hideView?.alpha = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


extension WriteTestVC {
    
    func setupUI() {
        self.view.backgroundColor = .clear
        txtText.delegate = self
        vuSend.setCirleCornerRadius()
        txtText.bor(radius: txtText.frame.height / 2, color: .lightGray)
        vuSend.backgroundColor = .lightGray
        DispatchQueue.main.async {
            self.txtText.becomeFirstResponder()
        }
    }
    
}


extension WriteTestVC: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            if UIDevice.current.userInterfaceIdiom == .pad {
                txtH.constant = 80
            }else{
                txtH.constant = 48
            }
        }else {
            let heigthOfScreen = UIScreen.main.bounds.height
            if txtH.constant <= (heigthOfScreen * 0.4) {
                txtH.constant = txtText.contentSize.height
            }
        }
        
        if txtText.text.replacingOccurrences(of: " ", with: "").isEmpty == true {
            vuSend.backgroundColor = .lightGray
        }else {
            vuSend.backgroundColor = .c4
        }
        
        self.view.layoutIfNeeded()
    }

}

extension WriteTestVC {

    static func createVC(parentView: UIView?,hideView: UIView?) -> WriteTestVC {
        let vc = UIStoryboard.init(name: "Test", bundle: nil).instantiateViewController(withIdentifier: "WriteTestVC") as! WriteTestVC
        vc.modalPresentationStyle = .overFullScreen
        vc.parentView = parentView
        vc.hideView = hideView
        return vc
    }

}
