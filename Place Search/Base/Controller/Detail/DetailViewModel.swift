//
//  DetailViewModel.swift
//  Place Search
//
//  Created by Everson Trindade on 27/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

protocol DetailLoadContent: class {
    func didLoadContent(error: String?)
}

protocol DetailViewModelPresentable: class {
    func getPlaceDetails(with placeID: String)
}

class DetailViewModel: DetailViewModelPresentable {

    private weak var loadContent: DetailLoadContent?
    
    init(loadContent: DetailLoadContent?) {
        self.loadContent = loadContent
    }

    func getPlaceDetails(with placeID: String) {
        DetailRequest(placeID: placeID).request { (result, error) in
            
        }
    }
}
