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
    func getReviews() -> [Review]
    func getDetails(index: Int) -> DetailViewCellDTO
}

class DetailViewModel: DetailViewModelPresentable {

    // MARK: Properties
    private weak var loadContent: DetailLoadContent?
    var detail: Detail?
    
    init(loadContent: DetailLoadContent?) {
        self.loadContent = loadContent
    }
    
    init() { }

    // MARK: Functions
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
    
    func getReviews() -> [Review] {
        guard let reviews = detail?.result?.reviews else {
            return []
        }
        return reviews
    }
    
    func getDetails(index: Int) -> DetailViewCellDTO {
        guard let detail = detail?.result else {
            return DetailViewCellDTO()
        }
        return DetailViewCellDTO(image: detail.photos?.object(index: 0)?.photo_reference ?? "",
                                 name: detail.name ?? "",
                                 phone: detail.formatted_phone_number ?? "",
                                 address: detail.formatted_address ?? "",
                                 url: detail.url ?? "")
    }
}
