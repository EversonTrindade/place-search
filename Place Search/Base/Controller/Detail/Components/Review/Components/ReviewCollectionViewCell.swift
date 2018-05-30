//
//  ReviewCollectionViewCell.swift
//  Place Search
//
//  Created by Everson Trindade on 29/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

struct ReviewCollectionCellDTO {
    var name = ""
//    var image =
    var rating = 0
    var review = ""
    var date = 0
    var url = ""
}

class ReviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var userReview: UITextView!
    
    private var authorUrl = ""
    
    func fillCell(dto: ReviewCollectionCellDTO) {
        userName.text = dto.name.uppercased()
        userRating.text = "Rating: \(dto.rating)"
        userReview.text = dto.review
        reviewDate.text = formatDate(date: dto.date)
        authorUrl = dto.url
    }
    
    func formatDate(date: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
        return dayTimePeriodFormatter.string(from: date as Date)
    }
    
    @IBAction func moreInfoAction(_ sender: Any) {
        if let url = URL(string: authorUrl) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
