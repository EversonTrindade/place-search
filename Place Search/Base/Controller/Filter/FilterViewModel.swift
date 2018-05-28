//
//  FilterViewModel.swift
//  Place Search
//
//  Created by Everson Trindade on 28/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import UIKit

protocol FilterViewModelPresentable: class {
    func numberOfSections() -> Int
    func numberOfRowsInSection() -> Int
    func heightForRow() -> CGFloat
    func getPlaceType(row: Int) -> String
}

class FilterViewModel: FilterViewModelPresentable {
    
    var placeTypes = [String]()
    
    init(placeTypes: [String]) {
        self.placeTypes = placeTypes
    }
    
    func getPlaceType(row: Int) -> String {
        guard let name = placeTypes.object(index: row) else {
            return ""
        }
        return name
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return placeTypes.count
    }
    
    func heightForRow() -> CGFloat {
        return 60.0
    }
}
