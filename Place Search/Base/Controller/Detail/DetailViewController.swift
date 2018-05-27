//
//  DetailViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 26/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailLoadContent {
    
    // MARK: Properties
    lazy var viewModel: DetailViewModelPresentable = DetailViewModel(loadContent: self)
    private var placeID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getPlaceDetails(with: placeID)
    }
    
    func fill(with placeID: String) {
        self.placeID = placeID
    }

    func didLoadContent(error: String?) {
        
    }
    
}
