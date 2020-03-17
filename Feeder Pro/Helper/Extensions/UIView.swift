
//
//  UIView.swift
//  SalonManager
//
//  Created by Sarath R on 08/12/18.
//  Copyright © 2018 SalonManager. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    
    
    func removeAllSubViews() {
     
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    
    func removeSubview<T>(of kind: T) {
        
        self.subviews.forEach({  if $0 is T { $0.removeFromSuperview() } })
    }
        
    
    // Set Constraints
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    
    
    func getfirstResponder() -> UIView? {
        
        guard !isFirstResponder else { return self }
        for subview in subviews {
            
            if let firstResponder = subview.getfirstResponder() {
                
                return firstResponder
            }
        }
        return nil
    }
}

extension UIView {
    
    // Set Shadow
    func addShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1) {
        
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shouldRasterize = false
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.9
        animation.values = [ 10.0, -10.0, 5.0, -5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
    
}

// Support Animation
extension UIView {
    
    func animate() {
        
        UIView.animate(withDuration: 0.05, animations: {
            
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (status) in
            
            UIView.animate(withDuration: 0.05, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}
// InputAssistant bug fix
extension UIView
{
    func fixInputAssistant()
    {
        for subview in self.subviews
        {
            if type(of: subview) is UITextField.Type
            {
                let item = (subview as! UITextField).inputAssistantItem
                item.leadingBarButtonGroups = []
                item.trailingBarButtonGroups = []
            }
            else if subview.subviews.count > 0
            {
                subview.fixInputAssistant()
            }
        }
    }
}
extension UIView{
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
