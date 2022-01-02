//
//  ZDSkyTextField.swift
//  Majdona
//
//  Created by Mahmoud on 4/27/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import UIKit

class ZDSkyTextField: UIView {

    
    
    @IBOutlet weak var CLeadingView: NSLayoutConstraint!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var lblPlaceHolder: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var dropDownIcon: UIImageView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var vuContain: UIView!
    @IBOutlet weak var lblLine: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commit()
        
    }
    
    func commit(){
        Bundle.main.loadNibNamed("ZDSkyTextField", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask  = [.flexibleHeight,.flexibleWidth]
        setupUI()
        
    }


    func setupUI () {
        self.backgroundColor = .clear
        self.image = nil
        self.iconData = nil
        self.errorMessage = ""
        textField.addTarget(self, action: #selector(didbeginWrite), for: .editingDidBegin)
        textField.addTarget(self, action: #selector(didendWrite), for: .editingDidEnd)
        textField.addTarget(self, action: #selector(didclickedPrimaryKey), for: .primaryActionTriggered)
        self.isSecure = false
        self.textField.returnKeyType = .done
        //self.setBorder()
        self.backgroundColor = .clear
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.textField.font = UIFont.init(name: "Cairo-Regular", size: 25)
            self.lblPlaceHolder.font = UIFont.init(name: "Cairo-Regular", size: 20)!
        }
    }
    
    var image: UIImage? {
        didSet {
            if image == nil {
                self.icon.isHidden = true
            }else {
                self.icon.isHidden = false
                self.icon.image = image
                icon.image = icon.image?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    
    var iconData: UIImage? {
        didSet {
            if iconData == nil {
                self.dropDownIcon.isHidden = true
            }else {
                self.dropDownIcon.image = iconData
                self.dropDownIcon.isHidden = false
            }
            
        }
    }
    
    var placeHolder: String? {
        didSet {
            self.lblPlaceHolder.text = self.placeHolder
            self.textField.placeholder = self.placeHolder
            
        }
    }
    
    var setCustomStyle: Bool? {
        didSet {
            self.vuContain.backgroundColor = .clear
            if self.setCustomStyle == true {
                self.lblLine.alpha = 1
                self.textField.backgroundColor = .clear
                self.CLeadingView.constant = 0
                self.lblPlaceHolder.textAlignment = .natural
            }else {
                self.textField.backgroundColor = .white
                if UIDevice.current.userInterfaceIdiom == .pad {
                    self.lblLine.alpha = 0
                    self.CLeadingView.constant = 40
                }else {
                    self.CLeadingView.constant = 25
                }
            }
            self.layoutIfNeeded()
        }
    }
    
    var keyboardType: UIKeyboardType? {
        didSet {
            self.textField.keyboardType = self.keyboardType ?? UIKeyboardType.default
        }
    }
    
    var text: String? {
        get {
            return self.textField.text
        }
        
        set {
            self.textField.text = newValue
            if newValue == "" {
                //self.lblPlaceHolder.alpha = 0
                self.lblPlaceHolder.alpha = 1
            }else {
                self.lblPlaceHolder.alpha = 1
            }
        }
    }
    
    var isSecure: Bool? {
        didSet {
            self.textField.isSecureTextEntry = isSecure ?? false
        }
    }
    
    var errorMessage : String? {
        didSet {
            if (self.errorMessage ?? "") == "" {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                    self.vuContain.layer.borderColor = UIColor.darkGray.cgColor
                    self.lblPlaceHolder.text = self.placeHolder
                    self.lblPlaceHolder.textColor = self.placeHolderColor()
                    self.layoutIfNeeded()
                    if self.textField.text == "" {
                        //self.lblPlaceHolder.alpha = 0
                        self.lblPlaceHolder.alpha = 1
                    }else{
                        self.lblPlaceHolder.alpha = 1
                    }
                    self.textField.textColor = self.getTextColor()
                    self.icon.tintColor = self.getTextColor()
                })
            }else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                    self.lblPlaceHolder.text = self.errorMessage
                    self.lblPlaceHolder.textColor = .red
                    self.vuContain.layer.borderColor = UIColor.red.cgColor
                    self.layoutIfNeeded()
                    self.textField.textColor = .red
                    self.icon.tintColor = .red
                    self.fadelblPlaceHolder(1)
                })
            }
        }
    }
}

// animation
extension ZDSkyTextField {
    
    func fadelblPlaceHolder(_ alpha: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            self.lblPlaceHolder.alpha = alpha
        }
    }
    
    func setBorder(_ color: UIColor? = nil) {
        if self.setCustomStyle == true {
            self.textField.setBottomBorder(color: UIColor.gray)
        }else {
            self.vuContain.bor(radius: 12, color: color ?? UIColor.darkGray)
        }
    }
    
    func getTextColor() -> UIColor {
        if self.setCustomStyle == true {
            return .darkGray
        }else {
            return UIColor.darkGray
        }
    }
    
    func placeHolderColor() -> UIColor {
        if self.setCustomStyle == true {
            return .darkGray
        }else {
            return UIColor.darkGray
        }
    }
}

//textFild Clicking Handle
extension ZDSkyTextField {
    
    @objc func didbeginWrite() {
        //fadelblPlaceHolder(1)
    }
    
    @objc func didendWrite() {
        if (self.errorMessage ?? "" ) == "" && self.textField.text == "" {
            //fadelblPlaceHolder(0)
        }
    }
    
    @objc func didclickedPrimaryKey() {
        self.textField.endEditing(true)
    }
}

extension UITextField {
  func setBottomBorder(color: UIColor) {
    self.borderStyle = UITextField.BorderStyle.none
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor = color.cgColor
    
    border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
    border.borderWidth = width
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
   }
}
