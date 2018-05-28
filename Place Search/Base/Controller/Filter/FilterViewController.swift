//
//  FilterViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 28/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {

    // MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    private var currentPlaceType = ""
    fileprivate let placeTypes = ["accounting", "airport", "amusement_park", "aquarium", "art_gallery", "atm", "bakery"]
    lazy var viewModel: FilterViewModelPresentable = FilterViewModel(placeTypes: self.placeTypes)
    private var saveButton = UIBarButtonItem()

    func setPlaceType(currentPlaceType: String) {
        self.currentPlaceType = currentPlaceType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        formatNavigationBar()
    }
    
    func formatNavigationBar() {
        saveButton = UIBarButtonItem(title: "Save",
                                     style: .plain,
                                     target: self,
                                     action: #selector(FilterViewController.saveButtonAction))
        saveButton.isEnabled = false
        navigationItem.rightBarButtonItems = [saveButton]
    }
    
    @objc func saveButtonAction() {
        
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterViewCell", for: indexPath) as? FilterViewCell else {
            return UITableViewCell()
        }
//        cell.accessoryType = currentPlaceType == viewModel.getPlaceType(row: indexPath.row) ? .checkmark : .none
        cell.fillCell(title: viewModel.getPlaceType(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            currentPlaceType = viewModel.getPlaceType(row: indexPath.row)
            saveButton.isEnabled = true
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
}
