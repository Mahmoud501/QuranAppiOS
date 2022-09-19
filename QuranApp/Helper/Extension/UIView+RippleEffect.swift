//
//  UIView+RippleEffect.swift
//  DalilApp
//
//  Created by Mahmoud on 3/10/20.
//  Copyright © 2020 Mahmoud. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addRippleEffect() {
        let referenceView = self
        /*! Creates a circular path around the view*/
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height))
        /*! Position where the shape layer should be */
        let shapePosition = CGPoint(x: referenceView.bounds.size.width / 2.0, y: referenceView.bounds.size.height / 2.0)
        let rippleShape = CAShapeLayer()
        rippleShape.bounds = CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height)
        rippleShape.path = path.cgPath
        let ripColor = UIColor.lightGray.cgColor //UIColor.init(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1).cgColor
        rippleShape.fillColor = ripColor        
        rippleShape.strokeColor = UIColor.clear.cgColor
        rippleShape.lineWidth = 4
        rippleShape.position = shapePosition
        rippleShape.opacity = 0
        
        /*! Add the ripple layer as the sublayer of the reference view */
        referenceView.layer.addSublayer(rippleShape)
        /*! Create scale animation of the ripples */
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
        scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
        /*! Create animation for opacity of the ripples */
        let opacityAnim = CABasicAnimation(keyPath: "opacity")
        opacityAnim.fromValue = 1
        opacityAnim.toValue = nil
        /*! Group the opacity and scale animations */
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnim, opacityAnim]
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.duration = CFTimeInterval(0.5)
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = true
        rippleShape.add(animation, forKey: "rippleEffect")
    }
    
    func addFullRippleEffect() {
           let referenceView = self
           /*! Creates a circular path around the view*/
           let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height))
           /*! Position where the shape layer should be */
           let shapePosition = CGPoint(x: referenceView.bounds.size.width / 2.0, y: referenceView.bounds.size.height / 2.0)
           let rippleShape = CAShapeLayer()
           rippleShape.bounds = CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height)
           rippleShape.path = path.cgPath
           let ripColor = UIColor.lightGray.cgColor //UIColor.init(displayP3Red: 242/255, green: 242/255, blue: 247/255, alpha: 1).cgColor
           rippleShape.fillColor = ripColor
           rippleShape.strokeColor = UIColor.clear.cgColor
           rippleShape.lineWidth = 4
           rippleShape.position = shapePosition
           rippleShape.opacity = 0
           
           /*! Add the ripple layer as the sublayer of the reference view */
           referenceView.layer.addSublayer(rippleShape)
           /*! Create scale animation of the ripples */
           let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
           scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
           scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
           /*! Create animation for opacity of the ripples */
           let opacityAnim = CABasicAnimation(keyPath: "opacity")
           opacityAnim.fromValue = 1
           opacityAnim.toValue = nil
           /*! Group the opacity and scale animations */
           let animation = CAAnimationGroup()
           animation.animations = [scaleAnim, opacityAnim]
           animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
           animation.duration = CFTimeInterval(0.5)
           animation.repeatCount = 1
           animation.isRemovedOnCompletion = true
           rippleShape.add(animation, forKey: "rippleEffect")
       }
    
    func addInFiniteFullRippleEffect() {
           let referenceView = self
           /*! Creates a circular path around the view*/
           let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height))
           /*! Position where the shape layer should be */
           let shapePosition = CGPoint(x: referenceView.bounds.size.width / 2.0, y: referenceView.bounds.size.height / 2.0)
           let rippleShape = CAShapeLayer()
           rippleShape.bounds = CGRect(x: 0, y: 0, width: referenceView.bounds.size.width, height: referenceView.bounds.size.height)
           rippleShape.path = path.cgPath
        let ripColor = UIColor.c2.cgColor
           rippleShape.fillColor = ripColor
           rippleShape.strokeColor = UIColor.clear.cgColor
           rippleShape.lineWidth = 4
           rippleShape.position = shapePosition
           rippleShape.opacity = 0
           
           /*! Add the ripple layer as the sublayer of the reference view */
           referenceView.layer.addSublayer(rippleShape)
           /*! Create scale animation of the ripples */
           let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
           scaleAnim.fromValue = NSValue(caTransform3D: CATransform3DIdentity)
           scaleAnim.toValue = NSValue(caTransform3D: CATransform3DMakeScale(2, 2, 1))
           /*! Create animation for opacity of the ripples */
           let opacityAnim = CABasicAnimation(keyPath: "opacity")
           opacityAnim.fromValue = 1
           opacityAnim.toValue = nil
           /*! Group the opacity and scale animations */
           let animation = CAAnimationGroup()
           animation.animations = [scaleAnim, opacityAnim]
           animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
           animation.duration = CFTimeInterval(0.5)
        animation.repeatCount = Float.greatestFiniteMagnitude
           animation.isRemovedOnCompletion = true
           rippleShape.add(animation, forKey: "rippleEffect")
       }

}
