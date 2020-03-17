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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        authorView.layoutIfNeeded()
        authorView.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 15.0)

    }
}
