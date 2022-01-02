//
//  BaseViewController.swift
//  QuranApp
//
//  Created by MAJED A  ALGARNI on 9/14/20.
//  Copyright © 2020 Wakeb. All rights reserved.
//

import UIKit
import DropDown


extension BaseViewController: UIGestureRecognizerDelegate {
      
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return (self.navigationController?.viewControllers.count ?? 0) > 1      
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
  
}

class BaseViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self        
     }
  
     
    
    override func viewDidLoad() {
        super.viewDidLoad()

     }
    
    //expired
    
    func setupSplach() {
        let imageview = UIImageView.init(image: UIImage.init(named: "bg"))
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.sizeToFit()
        view.insertSubview(imageview, at: 0)

        let centerIcon = UIImageView.init(image: UIImage.init(named: "logo_icon"))
        centerIcon.translatesAutoresizingMaskIntoConstraints = false
        centerIcon.sizeToFit()
        centerIcon.contentMode = .scaleAspectFit
        view.insertSubview(centerIcon, at: 1)
        
        var allConstraints: [NSLayoutConstraint] = []

        let views: [String: Any] = [
            "img": imageview,
            "icon": centerIcon,
            "superview":view!,

        ]
        
        let metrics = [
            "iconHeigth": (self.view.frame.width * 0.45) * 2,
            "iconWidth": (self.view.frame.width * 0.45)
        ]

        //vfl constraints
        
        //imageView
        //horitical
        let bgHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[img]-0-|", metrics: nil, views: views)
        //vertical
        let bgVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[img]-0-|", metrics: nil, views: views)
        allConstraints += bgHConstraints
        allConstraints += bgVConstraints
        
        
        //icon
        let containerCenterY = NSLayoutConstraint.constraints(withVisualFormat: "V:[superview]-(<=1)-[icon(==iconHeigth)]",
                                                              options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                                                              metrics: metrics, views: views)
        
        let containerCenterX = NSLayoutConstraint.constraints(withVisualFormat: "H:[superview]-(<=1)-[icon(==iconWidth)]",
                                                              options: NSLayoutConstraint.FormatOptions.alignAllCenterY,
                                                              metrics: metrics, views: views)
                
        allConstraints += containerCenterY
        allConstraints += containerCenterX

        
        view.addConstraints(allConstraints)
        NSLayoutConstraint.activate(allConstraints)
    }
    
    
    func setupColoredBackground() {
        
        

        
        let imageview = UIImageView.init(image: UIImage.init(named: "bg"))
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.sizeToFit()
        view.insertSubview(imageview, at: 0)
        
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = view.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        gradientLayer.colors = [UIColor.c1.cgColor, UIColor.c2.cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        // Apply the gradient to the backgroundGradientView.
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Bottom right corner.

        view.layer.insertSublayer(gradientLayer, at: 0)

        
        var allConstraints: [NSLayoutConstraint] = []

        let views: [String: Any] = [
            "img": imageview,
            "superview":view!,

        ]
    

        //vfl constraints
        
        
        //imageView
        //horitical
        let bgHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[img]-0-|", metrics: nil, views: views)
        //vertical
        let bgVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[img]-0-|", metrics: nil, views: views)
        allConstraints += bgHConstraints
        allConstraints += bgVConstraints
        
        
        
        view.addConstraints(allConstraints)
        NSLayoutConstraint.activate(allConstraints)
    }

    

    

    
    func setupDropDown(_ txt: UITextField? = nil, vu: UIView ,dropdown: DropDown ,source :[String], action: String) {
           txt?.isUserInteractionEnabled = false
           dropdown.anchorView = vu
           dropdown.dataSource = source
           dropdown.bottomOffset = CGPoint(x: 0, y:(dropdown.anchorView?.plainView.bounds.height)!)
           dropdown.topOffset = CGPoint(x: 0,y:-(dropdown.anchorView?.plainView.bounds.height)!)
           dropdown.direction = .any
    }
    
    // Make sure this is not private
    @IBAction func keyboard(_ sender: Any?) {
       self.view.endEditing(true)
    }
    
}

extension UIView {
    
    func setupGradientColor() {
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = self.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        gradientLayer.colors = [UIColor.c1.cgColor, UIColor.c2.cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        // Apply the gradient to the backgroundGradientView.
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 1, y: 1) // Bottom right corner.

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func setBackgroundLight() {
        // Create a gradient layer.
        let gradientLayer = CAGradientLayer()
        // Set the size of the layer to be equal to size of the display.
        gradientLayer.frame = self.bounds
        // Set an array of Core Graphics colors (.cgColor) to create the gradient.
        // This example uses a Color Literal and a UIColor from RGB values.
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.c2.cgColor]
        // Rasterize this static layer to improve app performance.
        gradientLayer.shouldRasterize = true
        // Apply the gradient to the backgroundGradientView.
        gradientLayer.startPoint = CGPoint(x: 0, y: 0) // Top left corner.
        gradientLayer.endPoint = CGPoint(x: 2, y: 2) // Bottom right corner.

        self.layer.insertSublayer(gradientLayer, at: 0)

    }
    
}
