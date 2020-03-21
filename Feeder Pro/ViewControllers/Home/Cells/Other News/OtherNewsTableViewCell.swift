//
//  OtherNewsTableViewCell.swift
//  Feeder Pro
//
//  Created by MacBook on 3/21/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class OtherNewsTableViewCell: UITableViewCell {
    
    //IBOutlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorNameLabel: UILabel!
    @IBOutlet var publishedAtLabel: UILabel!
    @IBOutlet var newsImageView: UIImageView!
    
    //Set from parent
    var cellData:Article?{
        didSet{
            DispatchQueue.main.async {
                self.setupUI()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI(){
        
        self.titleLabel.text = cellData?.title ?? "-"
        self.authorNameLabel.text = cellData?.title ?? "-"
        
        
        self.newsImageView.kf.indicatorType = .activity
        let url = URL(string: cellData?.urlToImage ?? "")
        self.newsImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "defaultImage"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
        ])
        
        
        self.titleLabel.text = cellData?.title ?? ""
        self.authorNameLabel.text = cellData?.author ?? (cellData?.source?.name ?? "Unknown author")
        if let publishedDateInString = cellData?.publishedAt {
            if let publishedDate = publishedDateInString.toDate(){
                self.publishedAtLabel.text = publishedDate.timeAgo(numericDates: true)
            }else{
                self.publishedAtLabel.text = cellData?.publishedAt ?? "a while ago"
            }
        }else{
            self.publishedAtLabel.text = cellData?.publishedAt ?? "a while ago"
        }
    }
    
}
