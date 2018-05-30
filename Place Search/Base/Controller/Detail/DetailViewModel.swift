//
//  DetailViewModel.swift
//  Place Search
//
//  Created by Everson Trindade on 27/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import UIKit

protocol DetailLoadContent: class {
    func didLoadContent(error: String?)
}

protocol DetailViewModelPresentable: class {
    func getPlaceDetails(with placeID: String)
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func heightForRow() -> CGFloat
    func getReviews(index: Int) -> [Review]
}

class DetailViewModel: DetailViewModelPresentable {

    private weak var loadContent: DetailLoadContent?
    private var detail: Detail?
    
    init(loadContent: DetailLoadContent?) {
        self.loadContent = loadContent
    }

    func getPlaceDetails(with placeID: String) {
        DetailRequest(placeID: placeID).request { (result, error) in
            guard let detail = result else {
                self.loadContent?.didLoadContent(error: "Error")
                return
            }
            self.detail = detail
            self.loadContent?.didLoadContent(error: nil)
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return 2
    }
    
    func heightForRow() -> CGFloat {
        return 276.0
    }
    
    func getReviews(index: Int) -> [Review] {
        guard let reviews = detail?.result?.reviews else {
            return []
        }
        return reviews
    }

}
