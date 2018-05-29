//
//  SearchViewCell.swift
//  Place Search
//
//  Created by Everson Trindade on 28/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

struct SearchDTO {
    var name = ""
    var rating = 0.0
    var open = false
}

class SearchViewCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var openLbl: UILabel!
    
    func fillCell(dto: SearchDTO) {
        nameLbl.text = dto.name
        ratingLbl.text = dto.rating == 0.0 ? "No rating" : "Rating: \(dto.rating)"
        openLbl.text = dto.open == true ? "Opened" : "Closed"
    }
}
