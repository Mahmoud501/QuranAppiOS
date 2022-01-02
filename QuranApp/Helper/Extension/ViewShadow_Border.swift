//
//  ViewShadow_Border.swift
//  Mapyyn
//
//  Created by MAHMOUD on 11/26/18.
//  Copyright © 2018 MAHMOUD. All rights reserved.
//

import UIKit

class ViewShadow_Border: NSObject {

}
extension UIView
{
    func bor(){
        //view.backgroundColor = .clear
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    func bor(_ withValue: CGFloat,_ borWidth: CGFloat? = nil){
        self.layer.cornerRadius = withValue
        self.layer.borderWidth = borWidth ?? 0
        self.layer.borderColor = UIColor.c1.cgColor
    }
    func shadow (){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        //UIColor.init(displayP3Red: 45/255, green: 122/255, blue: 134/255, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:0 )
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3.0
        
    }
    
    func shadow122 (){
           self.layer.shadowColor = UIColor.darkGray.cgColor
           //UIColor.init(displayP3Red: 45/255, green: 122/255, blue: 134/255, alpha: 1).cgColor
           self.layer.shadowOffset = CGSize(width: 0, height:0 )
           self.layer.shadowOpacity = 0.5
           self.layer.shadowRadius = 8.0
           
       }
    
    func shadow90 (){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:0 )
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        
    }
    
    func shadow91 (){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:0 )
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5.0
        
    }
    func bor2(){
        //self.backgroundColor = .clear
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.clear.cgColor
    }
    func bor22(){
        //self.backgroundColor = .clear
        self.layer.cornerRadius = 18
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.clear.cgColor
    }
    func HeaderBor(value:CGFloat){
        //self.backgroundColor = .clear
        self.layer.cornerRadius = value
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.clear.cgColor
    }
    func borblue(){
        //self.backgroundColor = .clear
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 0/255, green: 16/255, blue: 103/255, alpha: 1).cgColor
    }
    func borpink(){
        //self.backgroundColor = .clear
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.init(red: 237/255, green: 86/255, blue: 147/255, alpha: 1).cgColor
    }
    
    
    func bor(radius: CGFloat, color: UIColor, w: CGFloat? = nil ){
        self.layer.cornerRadius = radius
        self.layer.borderWidth = w ?? 1
        self.layer.borderColor = color.cgColor
    }
    
    
    func borColor(color:UIColor){
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    func borCricleColor(color:UIColor){
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 0.3
        self.layer.borderColor = color.cgColor
    }
    func borColor2(color:UIColor){
        self.layer.cornerRadius = 22
        self.layer.borderWidth = 1
        self.layer.borderColor = color.cgColor
    }
    func borImg(){
        //view.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.init(red: 186/255, green: 54/255, blue: 60/255, alpha: 1).cgColor
        self.clipsToBounds = true
    }
    func borImg2(){
        //view.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func borImg3(){
        //view.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.white.cgColor
    }
    func shadow22 (){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height:3 )
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0                
    }
    
    func shadow33 (){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height:3 )
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 10.0
    }

    
    func clearShadow (){
           self.layer.shadowColor = UIColor.clear.cgColor
           self.layer.shadowOffset = CGSize(width: 0, height:0 )
           self.layer.shadowOpacity = 0
           self.layer.shadowRadius = 0
       }
    
    func shadow23 (){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:3 )
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
    }
    func Blackshadow (){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height:3 )
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
    }
    func shadowmenu (){
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height:0 )
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 3.0
    }
    func shadow2 (){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height:3 )
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 2.0
        
    }
    func shadow3 (){
        self.layer.shadowColor = UIColor.red.cgColor
        self.layer.shadowOffset = CGSize(width: 3, height:3 )
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 4.0
        
    }
    func bor4(){
        
        self.layer.cornerRadius = 23.5
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.init(displayP3Red: 102/255, green: 45/255, blue: 144/255, alpha: 1).cgColor

    }

     

    
}
extension UITextField{
    
    func addPaddingSpace(space:Int){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height:0))
        self.leftView = paddingView
        self.leftViewMode = .always
        
}
    func addRigthPaddingSpace(space:Int){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: space, height:0))
        self.rightView = paddingView
        self.rightViewMode = .always
        
    }
}


 
