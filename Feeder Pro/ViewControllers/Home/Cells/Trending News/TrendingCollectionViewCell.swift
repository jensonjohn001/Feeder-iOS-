//
//  TrendingCollectionViewCell.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    
    //IBOutlets
    @IBOutlet var authorView: UIView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    @IBOutlet var blurBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        authorView.layoutIfNeeded()
        authorView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)

    }
    
    
    func setBlurView(){
        DispatchQueue.main.async {
            // Init a UIVisualEffectView which going to do the blur for us
            let blurView = UIVisualEffectView()
            // Make its frame equal the main view frame so that every pixel is under blurred
            blurView.frame = self.blurBackgroundView.bounds
            // Choose the style of the blur effect to regular.
            // You can choose dark, light, or extraLight if you wants
            if #available(iOS 13.0, *) {
                blurView.effect = UIBlurEffect(style: .systemUltraThinMaterialDark)
                //systemUltraThinMaterialDark
            } else {
                // Fallback on earlier versions
                blurView.effect = UIBlurEffect(style: .light)
            }
            
            blurView.tag = 1001
            if let oldBlurView = self.blurBackgroundView.viewWithTag(1001){
                oldBlurView.removeFromSuperview()
            }
            
            // Now add the blur view to the main view
            self.blurBackgroundView.addSubview(blurView)
            
            self.blurBackgroundView.sendSubviewToBack(blurView)
                //self.socialMediaBackgroundTableView.backgroundView = blurView
        }
        
        
        
    }
}
