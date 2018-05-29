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
    let segueSearch = "goToSearch"
}

class MapViewController: UIViewController, MapLoadContent, FilterPlaceTypeDelegate, SearchPlaceDelegate {
    
    // MARK: IBOutlet
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Properties
    lazy var viewModel: MapViewModelPresentable = MapViewModel(loadContent: self)
    var locationManager = CLLocationManager()
    var type = "shopping_mall"
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.title = type.formatFilterValue()
    }
    
    // MARK: FilterPlaceTypeDelegate
    func setPlaceType(type: String) {
        self.type = type
        DispatchQueue.main.async {
            self.mapView.removeAnnotations(self.mapView.annotations)
        }
        viewModel.getPlaces(coordinate: locationManager.location?.coordinate, type: type)
    }
    
    // MARK: MapLoadContent
    func didLoadContent(_ places: [Place]?, _ error: String?) {
        if let _ = error {
            showDefaultAlert(message: "XXXXX", completeBlock: nil)
        } else {
            if let places = places {
                for index in 0...places.count {
                    DispatchQueue.main.async {
                        self.mapView.addAnnotation(self.viewModel.addPinAnnotaionOnMap(with: index))
                    }
                }
            }
        }
    }
    
    // MARK: IBAction
    @IBAction func goToFilter(_ sender: Any) {
        performSegue(withIdentifier: Identifiers().segueFilter, sender: type)
    }
    
    @IBAction func goToSearch(_ sender: Any) {
        performSegue(withIdentifier: Identifiers().segueSearch, sender: nil)
    }

    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers().segueFilter {
            if let filterViewController = segue.destination as? FilterViewController, let type = sender as? String {
                filterViewController.setPlaceType(currentPlaceType: type)
                filterViewController.delegate = self
            }
        } else if segue.identifier == Identifiers().segueSearch {
            if let searchViewController = segue.destination as? SearchViewController {
                searchViewController.delegate = self
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
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        
//        let alertView = UIAlertController(title: "Action", message: nil, preferredStyle: .actionSheet)
//        alertView.addAction(UIAlertAction(title: "Detail", style: .default, handler: { (action) in
//            
//        }))
//        alertView.addAction(UIAlertAction(title: "Show In Map", style: .default, handler: { (action) in
//            
//        }))
//        alertView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(alertView, animated: true, completion: nil)
//    }
}
