//
//  ContactusVC.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/27/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import TransitionButton
import ZVProgressHUD

class ContactusVC: BaseViewController {

    var presenter: ContactusPresenter?
    
    @IBOutlet weak var txtSubject: ZDSkyTextField!
    @IBOutlet weak var txtName: ZDSkyTextField!
    @IBOutlet weak var txtEmail: ZDSkyTextField!    
    @IBOutlet weak var txtMessage: UITextView!    
    @IBOutlet weak var btnSend: TransitionButton!
    @IBOutlet weak var vuContain: UIView!
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendClicked(_ sender: Any) {
        ProgressHUD.shared.show()
        var request = SettingInOut.contactus.DefaultRqeuest()
        request.name = txtName.text
        request.email = txtEmail.text
        request.subject = txtSubject.text
        request.body = txtMessage.text
        presenter?.contactus(request: request)
    }
    

}


extension ContactusVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = ContactusPresenter.init(contactusView: self)
        setupUI()
    }
    
}


extension ContactusVC {
    
    func setupUI() {
        btnSend.spinnerColor = UIColor.c4
        btnSend.setBackgroundLight()
        btnSend.bor(radius: 13, color: .clear)
        btnSend.layer.masksToBounds = true
        setupColoredBackground()
        vuContain.bor(radius: 13, color: .clear)
        txtName.placeHolder = "What should I call you?".localized
        txtName.setCustomStyle =  true
        txtEmail.placeHolder = "Email Address".localized
        txtEmail.setCustomStyle =  true
        txtEmail.keyboardType = .emailAddress
        txtSubject.placeHolder = "Subject".localized
        txtSubject.setCustomStyle =  true
        txtMessage.backgroundColor = .clear
        txtMessage.bor(radius: 12, color: .lightGray)
    }
    
}



extension ContactusVC {
    static func createVC() -> ContactusVC {
        let vc = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "ContactusVC") as! ContactusVC
        return vc
    }
    
}
