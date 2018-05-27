//
//  HomeViewModel.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol HomeLoadContent: class {
    func didLoadContent(error: String?)
}

protocol HomeViewModelPresentable: class {
    func getPlaces(coordinate: CLLocationCoordinate2D?, type: String)
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func heightForRow() -> CGFloat
    func getCellDTO(index: Int) -> PlaceDTO
    func getPlaceId(index: Int) -> String
}

class HomeViewModel: HomeViewModelPresentable {
    
    private weak var loadContent: HomeLoadContent?
    private var places = [Place]()
    private var nextPageToken = ""
    
    init(loadContent: HomeLoadContent?) {
        self.loadContent = loadContent
    }
    
    func getPlaces(coordinate: CLLocationCoordinate2D?, type: String) {
        SearchRequest(location: getLocation(coordinate: coordinate), type: type).request { (result, error) in
            guard let places = result?.results else {
                self.loadContent?.didLoadContent(error: "Places not found!")
                return
            }
            self.places = places
            self.loadContent?.didLoadContent(error: nil)
        }
    }
    
    private func getLocation(coordinate: CLLocationCoordinate2D?) -> String {
        return "\(coordinate?.latitude ?? 0),\(coordinate?.longitude ?? 0)" 
    }
    
    func getCellDTO(index: Int) -> PlaceDTO {
        guard let place = places.object(index: index) else {
            return PlaceDTO()
        }
        return PlaceDTO(name: place.name ?? "", rating: place.rating ?? 0.0, open: place.opening_hours?.open_now ?? false)
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
