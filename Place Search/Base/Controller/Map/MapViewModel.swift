//
//  MapViewModel.swift
//  Place Search
//
//  Created by Everson Trindade on 27/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

protocol MapLoadContent: class {
    func didLoadContent(_ places: [Place]?,_ error: String?)
}

protocol MapViewModelPresentable: class {
    func getPlaces(coordinate: CLLocationCoordinate2D?, type: String)
    func getRegionFromLocation(locations: [CLLocation]) -> MKCoordinateRegion
    func addPinAnnotaionOnMap(with id: Int) -> MKPointAnnotation
}

class MapViewModel: MapViewModelPresentable {
    
    // MARK: Properties
    private weak var loadContent: MapLoadContent?
    private var places = [Place]()
    private var locationManager = CLLocationManager()
    private var userLocation = CLLocation()

    // MARK: funcitions
    init(loadContent: MapLoadContent) {
        self.loadContent = loadContent
    }

    func getPlaces(coordinate: CLLocationCoordinate2D?, type: String) {
        SearchRequest(location: getLocation(coordinate: coordinate), type: type, query: "").request { (result, error) in
            guard let places = result?.results else {
                self.loadContent?.didLoadContent(nil, "Places not found!")
                return
            }
            self.places = places.sorted { $0.name ?? "" < $1.name ?? "" }
            self.loadContent?.didLoadContent(self.places, nil)
        }
    }
    
    private func getLocation(coordinate: CLLocationCoordinate2D?) -> String {
        return "\(coordinate?.latitude ?? 0),\(coordinate?.longitude ?? 0)"
    }
    
    func getRegionFromLocation(locations: [CLLocation]) -> MKCoordinateRegion {
        guard let last = locations.last else {
            return MKCoordinateRegion()
        }
        
        userLocation = last
        let center = CLLocationCoordinate2D(latitude: self.userLocation.coordinate.latitude, longitude: self.userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        return region
    }
    
    func addPinAnnotaionOnMap(with id: Int) -> MKPointAnnotation {
        guard let place = places.object(index: id) else {
            return MKPointAnnotation()
        }
        
        let location = CLLocationCoordinate2DMake(place.geometry?.location?.lat ?? 0, place.geometry?.location?.lng ?? 0)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "\(place.name ?? "") - Rating: \(place.rating ?? 0)"
        annotation.subtitle = "\(getDist(userLocation.coordinate, annotation.coordinate)) Km of distance\(checkIfIsClosed(open: place.opening_hours?.open_now))"
        return annotation
    }
    
    private func checkIfIsClosed(open: Bool?) -> String {
        return open == true ? " - Open" : " - Closed"
    }
    
    func getDist(_ userCoordinate: CLLocationCoordinate2D,_ pinCoordinate: CLLocationCoordinate2D) -> String{
        let user = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let annotation = CLLocation(latitude: pinCoordinate.latitude, longitude: pinCoordinate.longitude)
        let distanceInMeters = user.distance(from: annotation)
        return String(format: "%.2f", distanceInMeters / 1000)
    }
}
