//
//  SearchViewController.swift
//  Place Search
//
//  Created by Everson Trindade on 28/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

protocol SearchPlaceDelegate: class {
    func setPlaceType(type: String)
}

class SearchViewController: UIViewController, SearchLoadContent {
    
    // MARK: Properties
    weak var delegate: SearchPlaceDelegate?
    lazy var viewModel: SearchViewModelPresentable = SearchViewmodel(loadContent: self)
    
    // MARK: IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

    // MARK: IBAction
    @IBAction func cancelAction(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func searchAction(_ sender: Any) {
        getPlaces()
    }
    
    // MARK: functions
    func getPlaces() {
        showLoader()
        view.endEditing(true)
        viewModel.getPlace(query: searchBar.text ?? "")
    }

    // MARK: SearchLoadContent
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
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getPlaces()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchViewCell", for: indexPath) as? SearchViewCell else {
            return UITableViewCell()
        }
        cell.fillCell(dto: viewModel.getCellDTO(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
}