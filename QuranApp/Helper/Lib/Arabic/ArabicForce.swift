//
//  ArabicForce.swift
//
//  Created by MAHMOUD on 12/25/18.
//  Copyright © 2018 MAHMOUD. All rights reserved.
//

import UIKit



extension UIView{
        open override func awakeFromNib() {
            super.awakeFromNib()
            if self.tag == 100{
                self.semanticContentAttribute = .forceLeftToRight
                return
            }
            let lang = UserDefaults.standard.object(forKey: "loclz") as? String
            if lang != nil{
            if lang == "en"{ // view localization but com not
                self.semanticContentAttribute = .forceLeftToRight
            }else{
                self.semanticContentAttribute = .forceRightToLeft
            }
        }
    }
}

extension UITableView{
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        let lang = UserDefaults.standard.object(forKey: "loclz") as? String
        if lang != nil{
            if lang == "en"{
                self.semanticContentAttribute = .forceLeftToRight
            }else{
                self.semanticContentAttribute = .forceRightToLeft
            }
        }
    }
}


extension UICollectionView{
    open override func awakeFromNib() {
        super.awakeFromNib()
        let lang = UserDefaults.standard.object(forKey: "loclz") as? String
        if lang != nil{
            if lang == "en"{
                self.semanticContentAttribute = .forceLeftToRight
            }else{
                self.semanticContentAttribute = .forceRightToLeft
            }
        }
       
    }

    
}


extension UIButton {
    
      open override func awakeFromNib() {
        super.awakeFromNib()
        let lang = UserDefaults.standard.object(forKey: "loclz") as? String
        if lang != nil && self.titleLabel?.textAlignment != NSTextAlignment.center {
            if lang == "en"{
                self.semanticContentAttribute = .forceLeftToRight
            }else{
                self.semanticContentAttribute = .forceRightToLeft
            }
        }
    }

    
}

extension UITextField
{
    override open func awakeFromNib() {
        super.awakeFromNib()
        handleLang()
    }
    
    func handleLang()
    {
        if self.textAlignment != .center
        {
            let lang = UserDefaults.standard.object(forKey: "loclz") as? String
            if lang != nil {
                if lang == "en"
                {
                    self.textAlignment = .left
                }else{
                    self.textAlignment = .right
                }
            }
        }
    }

}

extension UITextView
{
    override open func awakeFromNib() {
        super.awakeFromNib()
        handleLang()
    }
    
    func handleLang()
    {
        if self.textAlignment != .center
        {
            let lang = UserDefaults.standard.object(forKey: "loclz") as? String
            if lang != nil{
                if lang == "en"{
                    self.textAlignment = .left
                }else{
                    self.textAlignment = .right
                }
            }
        }
    }
    
}
