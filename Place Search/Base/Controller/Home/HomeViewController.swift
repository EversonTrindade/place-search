//
//  HomeViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, HomeLoadContent {

    lazy var viewModel: HomeViewModelPresentable = HomeViewModel(loadContent: self)
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configUserLocation()
    }
    
    func didLoadContent(user: Place?, error: String?) {
        
    }
    
    // MARK: User Position
    func configUserLocation() {
        if CLLocationManager.authorizationStatus() == .notDetermined{
            self.locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            showDefaultAlert(message: "Location access denied. Turn on location service in settings.", completeBlock: nil)
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
//            viewModel.getPlaces()
            
            print("Lat: \(locationManager.location?.coordinate.latitude ?? 0)")
            print("Lon: \(locationManager.location?.coordinate.longitude ?? 0)")
        }
    }
}
