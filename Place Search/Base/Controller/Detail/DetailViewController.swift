//
//  DetailViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 26/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController, DetailLoadContent {
    
    // MARK: IBOutlet
    @IBOutlet weak var detailImg: UIImage!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var openLbl: UILabel!
    
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

    func didLoadContent(detail: Detail?, error: String?) {
        dismissLoader()
        if let err = error {
            showDefaultAlert(message: err, completeBlock: nil)
        } else {
            fillCell(detail: detail)
        }
    }
    
    private func fillCell(detail: Detail?) {
        if let detail = detail {
//            phoneLbl.text = detail.result?.formatted_phone_number
//            addressLbl.text = detail.result?.formatted_address
//            websiteLbl.text = detail.result?.website
//            ratingLbl.text = "\(detail.result?.rating ?? 0)"
//            openLbl.text = "\(detail.result?.opening_hours?.open_now ?? false)"
//
//            self.tableView.reloadData()
        }
    }
    
}
