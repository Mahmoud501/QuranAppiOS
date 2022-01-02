//
//  AppTextField.swift
//  BioSmartApp
//
//  Created by Mahmoud on 1/26/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

//import Foundation
//import UIKit
//
//class AppTextField: SkyFloatingLabelTextFieldWithIcon {
//    
//    override func awakeFromNib() {
//        style()
//    }
//    
//    @IBInspectable var ZikoIcon: String? = nil {
//        didSet {
//            if ZikoIcon != nil {
//                self.iconImage = UIImage(named: ZikoIcon!)
//            }
//        }
//    }
//    
//    
//    func style() {
//        self.handleLang()
//        self.templateImage = true
//        self.setNeedsLayout()
//        self.font = UIFont.init(name: "Cairo-Regular", size: 15)
//        self.titleFont = UIFont.init(name: "Cairo-Regular", size: 8)!
//
//        self.iconWidth = 15
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            self.font = UIFont.init(name: "Cairo-Regular", size: 25)
//            self.titleFont = UIFont.init(name: "Cairo-Regular", size: 12)!
//            self.iconWidth = 25
//        }
//        if self.iconImage == nil {
//            self.iconWidth = 0
//        }
//        self.iconType = .image
//        self.iconMarginLeft = 10
//        //self.iconMarginBottom = 0
//        self.selectedLineHeight = 2
//        self.lineHeight = 1
//        self.selectedLineColor = AppColor.c1
//        self.textColor = AppColor.c1
//        self.selectedTitleColor = AppColor.c1
//        self.superview?.backgroundColor = .clear
//        self.selectedIconColor = AppColor.c1
//        self.addTarget(self, action: #selector(startEdit), for: UIControl.Event.editingDidBegin)
//        self.addTarget(self, action: #selector(endEdit), for: UIControl.Event.editingDidEnd)
//    }
//    
//    
//    func style2() {
//        self.handleLang()
//        self.font = UIFont.init(name: "Cairo-Bold", size: 15)
//        self.titleFont = UIFont.init(name: "Cairo-Bold", size: 8)!
//
//        self.iconWidth = 15
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            self.font = UIFont.init(name: "Cairo-Bold", size: 25)
//            self.titleFont = UIFont.init(name: "Cairo-Bold", size: 12)!
//            self.iconWidth = 25
//        }
//        if self.iconImage == nil {
//            self.iconWidth = 0
//        }
//        self.iconType = .font
//        self.iconMarginLeft = 0
//        self.selectedLineHeight = 2
//        self.lineHeight = 1
//        self.selectedLineColor = .darkGray
//        self.textColor = .darkGray
//        self.selectedTitleColor = .black
//        self.superview?.backgroundColor = .clear
//        self.selectedIconColor = .darkGray
//        self.addTarget(self, action: #selector(startEdit), for: UIControl.Event.editingDidBegin)
//        self.addTarget(self, action: #selector(endEdit), for: UIControl.Event.editingDidEnd)
//    }
//    
//    func style3() {
//           self.handleLang()
//           self.font = UIFont.init(name: "Cairo-Bold", size: 15)
//           self.titleFont = UIFont.init(name: "Cairo-Bold", size: 8)!
//
//           self.iconWidth = 15
//           if UIDevice.current.userInterfaceIdiom == .pad {
//               self.font = UIFont.init(name: "Cairo-Bold", size: 25)
//               self.titleFont = UIFont.init(name: "Cairo-Bold", size: 12)!
//               self.iconWidth = 25
//           }
//           if self.iconImage == nil {
//               self.iconWidth = 0
//           }
//           self.iconType = .font
//           self.iconMarginLeft = 0
//           self.selectedLineHeight = 2
//           self.lineHeight = 1
//           self.selectedLineColor = AppColor.c2
//            self.textColor = .white
//           self.selectedTitleColor = AppColor.c2
//           self.superview?.backgroundColor = .clear
//           self.addTarget(self, action: #selector(startEdit), for: UIControl.Event.editingDidBegin)
//           self.addTarget(self, action: #selector(endEdit), for: UIControl.Event.editingDidEnd)
//       }
//    
//    
//    
//    func setIcon(icon: String) {
//        self.iconImage = UIImage(named: icon)
//    }
//    
//    @objc func startEdit() {
//        self.templateImage = true
//        self.setNeedsLayout()
//    }
//    
//    @objc func endEdit() {
//        self.templateImage = true
//        self.setNeedsLayout()
//    }
//    
//}
//
//class AppTextFiledContainer: UIView {
//    var textField: AppTextField! = AppTextField(frame: CGRect.zero, iconType: .image)
//    
//    @IBInspectable var icon: String? = nil {
//        didSet {
//            if icon != nil {
//                self.textField.setIcon(icon: icon!)
//            }else{
//                self.textField.iconWidth = 0
//            }
//        }
//    }
//    
//    @IBInspectable var placeHolder: String? = nil {
//        didSet {
//            self.textField.placeholder = placeHolder?.localized
//        }
//    }
//    
//    @IBInspectable var title: String? = nil {
//        didSet {
//            self.textField.title = title?.localized
//        }
//    }
//    
//    override func awakeFromNib() {
//        addTextFieldToView()
//        textField.style()
//        setupHeigth()
//    }
//    
//    @discardableResult
//    func setupHeigth()-> CGFloat {
//        let constraint = self.constraints.first(where: {$0.firstAttribute == .height})
//        var h: CGFloat = 47
//        if UIDevice.current.userInterfaceIdiom == .pad {
//             h = 100
//        }
//        constraint?.constant = h
//        return h
//    }
//    
//    func addTextFieldToView() {
//        self.addSubview(textField)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        self.addConstraint(NSLayoutConstraint(item: textField as Any, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: textField as Any, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: textField as Any, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
//        self.addConstraint(NSLayoutConstraint(item: textField as Any, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
//    }
//}
