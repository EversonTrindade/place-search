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

fileprivate struct Identifier {
    let seachCell = "SearchViewCell"
    let notSeached = "SearchNotFoundViewCell"
    let detail = "goToDetail"
}

class SearchViewController: UIViewController, SearchLoadContent {
    
    // MARK: Properties
    weak var delegate: SearchPlaceDelegate?
    lazy var viewModel: SearchViewModelPresentable = SearchViewModel(loadContent: self)
    
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
    func didLoadContent(places: [Place]?, error: String?) {
        dismissLoader()
        if let error = error {
            showDefaultAlert(message: error, completeBlock: nil)
        } else {
            guard let places = places else {
                return
            }
            if places.count == 0 {
                showDefaultAlert(message: "Nothing found :/", completeBlock: nil)
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifier().detail {
            if let detailViewController = segue.destination as? DetailViewController, let placeId = sender as? String {
                detailViewController.fill(with: placeId)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier().seachCell, for: indexPath) as? SearchViewCell else {
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
