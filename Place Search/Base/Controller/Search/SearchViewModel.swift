//
//  SearchViewModel.swift
//  Place Search
//
//  Created by Everson Trindade on 28/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import UIKit

protocol SearchLoadContent: class {
    func didLoadContent(error: String?)
}
protocol SearchViewModelPresentable: class {
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func heightForRow() -> CGFloat
    func getPlace(query: String)
    func getCellDTO(index: Int) -> SearchDTO
}

class SearchViewmodel: SearchViewModelPresentable {
    private weak var loadContent: SearchLoadContent?
    private var places = [Place]()
    
    init(loadContent: SearchLoadContent) {
        self.loadContent = loadContent
    }
    
    func getPlace(query: String) {
        SearchRequest(location: "", type: "", query: query.formatSeachValue()).request { (result, error) in
            guard let places = result?.results else {
                self.loadContent?.didLoadContent(error: "Places not found!")
                return
            }
            self.places = places
            self.loadContent?.didLoadContent(error: nil)
        }
    }
    
    func getCellDTO(index: Int) -> SearchDTO {
        guard let place = places.object(index: index) else {
            return SearchDTO()
        }
        return SearchDTO(name: place.name ?? "", rating: place.rating ?? 0.0, open: place.opening_hours?.open_now ?? false)
    }
    
    func getPlaceId(index: Int) -> String {
        if let id = places.object(index: index) {
            return id.place_id ?? ""
        }
        return ""
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return places.count
    }
    
    func heightForRow() -> CGFloat {
        return 85.0
    }
}
