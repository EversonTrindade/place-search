//
//  HomeViewModel.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

protocol HomeLoadContent: class {
    func didLoadContent(user: Place?, error: String?)
}

protocol HomeViewModelPresentable: class {
    func getPlaces()
}

class HomeViewModel: HomeViewModelPresentable {
    
    private weak var loadContent: HomeLoadContent?
    
    init(loadContent: HomeLoadContent?) {
        self.loadContent = loadContent
    }
    
    func getPlaces() {
        SearchRequest(location: "", type: "", keyword: "").request { (result, error) in
            
        }
    }
}
