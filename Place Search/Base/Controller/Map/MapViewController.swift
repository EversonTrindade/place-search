//
//  MapViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 26/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

fileprivate struct Identifiers {
    let segueFilter = "goToFilter"
}

class MapViewController: UIViewController, MapLoadContent {

    // MARK: IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    
    // MARK: Properties
    lazy var viewModel: MapViewModelPresentable = MapViewModel(loadContent: self)
    var locationManager = CLLocationManager()
    var type = "amusement_park"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = type.formatFilterValue()
    }

    // MARK: MapLoadContent
    func didLoadContent(_ places: [Place]?, _ error: String?) {
        if let _ = error {
            showDefaultAlert(message: "XXXXX", completeBlock: nil)
        } else {
            if let places = places {
                for index in 0...places.count {
                    mapView.addAnnotation(viewModel.addPinAnnotaionOnMap(with: index))
                }
            }
        }
    }
    
    // MARK: IBAction
    @IBAction func searchAction(_ sender: Any) {
        
    }
    
    @IBAction func goToFilter(_ sender: Any) {
        performSegue(withIdentifier: Identifiers().segueFilter, sender: type)
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers().segueFilter {
            if let filterViewController = segue.destination as? FilterViewController, let type = sender as? String {
                filterViewController.setPlaceType(currentPlaceType: type)
            }
        }
    }
    
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        mapView.setRegion(viewModel.getRegionFromLocation(locations: locations), animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied {
            showDefaultAlert(message: "Location access denied. Turn on location service in settings.", completeBlock: nil)
        } else if status == .authorizedWhenInUse{
            viewModel.getPlaces(coordinate: locationManager.location?.coordinate, type: type)
        } else if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
    }
    
    
}
