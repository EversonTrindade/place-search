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
    var image = ""
    var rating = 0
    var review = ""
    var date = 0
    var url = ""
}

class ReviewCollectionViewCell: UICollectionViewCell, ReviewCollectionCellLoadContent {

    // MARK: IBOutlet
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var reviewDate: UILabel!
    @IBOutlet weak var userReview: UITextView!
    
    // MARK: Properties
    private var reviewDTO: ReviewCollectionCellDTO?
    lazy var viewModel: ReviewCollectionViewCellModelPresentable = ReviewCollectionViewCellModel(loadContent: self, imageId: self.reviewDTO?.image ?? "")
    
    // MARK: Functionss
    func fillCell(dto: ReviewCollectionCellDTO) {
        reviewDTO = dto
        userName.text = dto.name.uppercased()
        userRating.text = "Rating: \(dto.rating)"
        userReview.text = dto.review
        reviewDate.text = viewModel.formatDate(date: dto.date)
        userImage.image = viewModel.getImage()
    }
    
    @IBAction func moreInfoAction(_ sender: Any) {
        viewModel.openUrl(authorUrl: reviewDTO?.url ?? "")
    }
    
    func didLoadImage() {
        userImage.image = viewModel.imageFromCache()
    }
}
