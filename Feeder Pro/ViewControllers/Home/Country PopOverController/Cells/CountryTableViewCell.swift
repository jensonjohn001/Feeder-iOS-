//
//  CountryTableViewCell.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    //IBOutlets
    @IBOutlet var countryImageView: UIImageView!
    @IBOutlet var selectedImageView: UIImageView!
    @IBOutlet var countryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
