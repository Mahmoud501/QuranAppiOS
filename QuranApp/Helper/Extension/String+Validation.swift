//
//  String+Validation.swift
//  EventHub
//
//  Created by Mahmoud on 3/28/1398 AP.
//  Copyright © 1398 Mahmoud. All rights reserved.
//

import Foundation

extension String
{
    
    var isBlank:Bool{
        if  self == "" || (self).replacingOccurrences(of: " ", with: "").isEmpty || self == "null"
        {
            return true
        }
        return false
    }
    
    
    var isValidEmail:Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    var isValidPhone:Bool {
        for char in self{
            if !char.isNumber{
                return false
            }
        }
        return true
    }
    
    func isVaildLength (length:Int)->Bool{ //length of pass
        if self.count < length{
            return false
        }else{
            return true
        }
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
   
    
}
