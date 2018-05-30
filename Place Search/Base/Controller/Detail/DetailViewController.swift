//
//  DetailViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 26/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, DetailLoadContent {
    
    // MARK: IBOutlet

    @IBOutlet var tableView: UITableView!
    
    // MARK: Properties
    lazy var viewModel: DetailViewModelPresentable = DetailViewModel(loadContent: self)
    private var placeID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoader()
        viewModel.getPlaceDetails(with: placeID)
    }
    
    func fill(with placeID: String) {
        self.placeID = placeID
    }

    func didLoadContent(error: String?) {
        dismissLoader()
        if let err = error {
            showDefaultAlert(message: err, completeBlock: nil)
        } else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailViewCell", for: indexPath) as? DetailViewCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewViewCell", for: indexPath) as? ReviewViewCell else {
                return UITableViewCell()
            }
            cell.fillCollection(reviews: viewModel.getReviews(index: indexPath.row))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
}
