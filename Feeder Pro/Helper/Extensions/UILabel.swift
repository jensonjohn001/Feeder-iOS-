//
//  UILabel.swift
//  BBSTests
//
//  Created by StackonMac3 on 26/07/19.
//  Copyright © 2019 BBS. All rights reserved.
//

import Foundation
import UIKit

// EmptyTable view text change animation
extension UILabel {
    func pushUp(_ text: String?) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromTop
        animation.duration = 0.4
        if self.text != text{
            self.layer.add(animation,  forKey: CATransitionType.push.rawValue)
            self.text = text
        }
    }
    
    func fadeInOut(_ text: String?) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.subtype = CATransitionSubtype.fromBottom
        animation.duration = 0.4
        if self.text != text{
            self.layer.add(animation,  forKey: CATransitionType.fade.rawValue)
            self.text = text
        }
    }
}
