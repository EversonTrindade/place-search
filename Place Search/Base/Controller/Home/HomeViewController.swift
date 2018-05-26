//
//  HomeViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit
import CoreLocation

fileprivate struct Identifier {
    let place = "PlaceViewCell"
    let noPlace = "NoPlaceViewCell"
    let detail = "showDetail"
}

class HomeViewController: UIViewController, HomeLoadContent {
    
    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    lazy var viewModel: HomeViewModelPresentable = HomeViewModel(loadContent: self)
    var locationManager = CLLocationManager()
    var type = "car_repair"
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configUserLocation()
    }
    
    // MARK: HomeLoadContent
    func didLoadContent(error: String?) {
        dismissLoader()
        if let error = error {
            showDefaultAlert(message: error, completeBlock: nil)
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: User Position
    func configUserLocation() {
        if CLLocationManager.authorizationStatus() == .notDetermined{
            self.locationManager.requestWhenInUseAuthorization()
        } else if CLLocationManager.authorizationStatus() == .denied {
            showDefaultAlert(message: "Location access denied. Turn on location service in settings.", completeBlock: nil)
        } else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            showLoader()
            viewModel.getPlaces(coordinate: locationManager.location?.coordinate, type: type)
        }
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier().detail {
            //AQUI
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier().place, for: indexPath) as? PlaceViewCell else {
            return UITableViewCell()
        }
        cell.fillCell(dto: viewModel.getCellDTO(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Identifier().detail, sender: viewModel.getPlaceId(index: indexPath.row))
    }
}
