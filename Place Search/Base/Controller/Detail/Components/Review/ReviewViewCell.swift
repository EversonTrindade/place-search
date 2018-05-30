//
//  ReviewViewCell.swift
//  Place Search
//
//  Created by Everson Trindade on 27/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class ReviewViewCell: UITableViewCell, ReviewLoadContent {
    
    // MARK: IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    private var arrayOfReview = [Review]()
    lazy var viewModel: ReviewViewCellModelPresentable = ReviewViewCellModel(reviews: self.arrayOfReview, loadContent: self)
    
    // MARK: Functions
    func fillCollection(reviews: [Review]) {
        self.arrayOfReview = reviews
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    func didLoadContent(error: String?) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension ReviewViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.fillCell(dto: viewModel.reviewDTO(index: indexPath.row))
        return cell
    }
}
