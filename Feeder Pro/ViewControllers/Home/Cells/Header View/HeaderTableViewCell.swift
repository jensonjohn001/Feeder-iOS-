//
//  HeaderTableViewCell.swift
//  Feeder Pro
//
//  Created by MacBook on 3/21/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    //IBOutlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var showAllButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showAllButtonAction(_ sender: UIButton){
        
    }
    
}
