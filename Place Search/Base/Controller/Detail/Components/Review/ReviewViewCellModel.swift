//
//  ReviewViewCellModel.swift
//  Place Search
//
//  Created by Everson Trindade on 29/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

protocol ReviewLoadContent: class {
    func didLoadContent(error: String?)
}

protocol ReviewViewCellModelPresentable: class {
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func reviewDTO(index: Int) -> ReviewCollectionCellDTO
}

class ReviewViewCellModel: ReviewViewCellModelPresentable {
    
    private var reviews = [Review]()
    private weak var loadContent: ReviewLoadContent?
    
    init(reviews: [Review], loadContent: ReviewLoadContent) {
        self.reviews = reviews
        self.loadContent = loadContent
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return reviews.count
    }
    
    func reviewDTO(index: Int) -> ReviewCollectionCellDTO {
        guard let review = reviews.object(index: index) else {
            return ReviewCollectionCellDTO()
        }
        return ReviewCollectionCellDTO(name: review.author_name ?? "",
                                       rating: review.rating ?? 0,
                                       review: review.text ?? "",
                                       date: review.time ?? 0,
                                       url: review.author_url ?? "")
    }

}
