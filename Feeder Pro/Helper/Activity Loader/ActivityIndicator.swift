//
//  ActivityIndicator.swift
//  SalonManager
//
//  Created by Jenson on 11/12/18.
//  Copyright © 2018 SalonManager. All rights reserved.
//

import Foundation
import UIKit


class ActivityIndicator: UIView {
    
    // UI Elements
    lazy var activityIndictor: UIActivityIndicatorView =  {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.color = #colorLiteral(red: 0.231372549, green: 0.2666666667, blue: 0.2941176471, alpha: 1)
        return indicator
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.3725490196, green: 0.4156862745, blue: 0.4901960784, alpha: 1)
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    lazy var contentView: UIView = {
       return UIView()
    }()
    
    // Declaration
    var text: String? {
        didSet {
            
            label.text = text
        }
    }
    
    
    // MARK: Life Cycle
    init(text: String) {
        
        self.text = text
        super.init(frame: CGRect.zero)
        self.setup()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        
        self.text = ""
        super.init(coder: aDecoder)
        self.setup()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let superview = self.superview {
            
            updateFrame(superview)
        }
    }
    
    
    
    // MARK: Arrange View
    func setup() {
        
        // Style
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        self.isHidden = true
        
        contentView.backgroundColor = .white
        contentView.cornerRadius = 4
        contentView.clipsToBounds = true
        contentView.addShadow(color: .black, opacity: 0.1, offSet: CGSize(width: 1, height: 1), radius: 4)
        
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        addSubview(contentView)
        
        activityIndictor.startAnimating()
    }
    
    
    
    func updateFrame(_ superview: UIView) {
        
        // Estimate Size
        let activityIndicatorSize: CGFloat = 40
        let textWidth = ceil(text?.textSize(of: UIFont.systemFont(ofSize: 16)).width ?? 0)
        let width: CGFloat = 8 + activityIndicatorSize + 8 + textWidth + 24
        let height: CGFloat = 24 + activityIndicatorSize + 24

        // Set Frames
        self.frame = UIScreen.main.bounds
        contentView.frame = CGRect(x: UIScreen.main.bounds.size.width / 2 - width / 2, y: UIScreen.main.bounds.height / 2 - height / 2, width: width, height: height)
        
        activityIndictor.frame = CGRect(x: 8, y: contentView.frame.height / 2 -  activityIndicatorSize / 2, width: activityIndicatorSize, height: activityIndicatorSize)
        label.frame = CGRect(x: (8 + activityIndicatorSize + 8), y: 0, width: textWidth + 8, height: height)
        
        // Set Value
        label.text = text
    }
    
    
    
    func show(_ containerView: UIView? = nil) {
        
        var _containerView = containerView
        DispatchQueue.main.async {
            
            if self.isHidden {
                
                if _containerView == nil {
                    
                    _containerView = UIApplication.shared.keyWindow
                }
                
                _containerView?.addSubview(self)
                self.isHidden = false
            }
        }
    }
    
    
    
    func hide() {
        
        DispatchQueue.main.async {
            
            self.isHidden = true
            self.removeFromSuperview()
        }
    }
}
