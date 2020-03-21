//
//  TrendingTableViewCell.swift
//  Feeder Pro
//
//  Created by MacBook on 3/14/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
import Kingfisher

class TrendingTableViewCell: UITableViewCell {
    
    //IBOutlets
    @IBOutlet var trendingCollectionView: UICollectionView!
    
    //Set from parent
    var cellData:[Article]?{
        didSet{
            DispatchQueue.main.async {
                self.trendingCollectionView.reloadData()
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
    
    
}
// MARK: -Collection View delegates
extension TrendingTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.cellData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let nibName = UINib(nibName: "TrendingCollectionViewCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "TrendingCollectionViewCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCollectionViewCell", for: indexPath) as! TrendingCollectionViewCell
        
        if let article = self.cellData?[indexPath.row]{
            
            cell.newsImageView.kf.indicatorType = .activity
            let url = URL(string: article.urlToImage ?? "")
            cell.newsImageView.kf.setImage(
                with: url,
                placeholder: UIImage(named: "defaultImage"),
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            
            cell.titleLable.text = article.title ?? ""
            cell.authorNameLabel.text = article.author ?? (article.source?.name ?? "Unknown author")
            if let publishedDateInString = article.publishedAt {
                if let publishedDate = publishedDateInString.toDate(){
                    cell.publishedAtLabel.text = publishedDate.timeAgo(numericDates: true)
                }else{
                    cell.publishedAtLabel.text = article.publishedAt ?? "a while ago"
                }
            }else{
                cell.publishedAtLabel.text = article.publishedAt ?? "a while ago"
            }
            
            cell.setBlurView()
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 250, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
}
