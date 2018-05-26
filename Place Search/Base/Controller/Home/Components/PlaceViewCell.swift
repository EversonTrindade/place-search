//
//  PlaceViewCell.swift
//  Place Search
//
//  Created by Everson Trindade on 26/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

struct PlaceDTO {
    var name = ""
    var rating = 0.0
    var open = false
}

class PlaceViewCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var openNowLbl: UILabel!
 
    func fillCell(dto: PlaceDTO) {
        nameLbl.text = dto.name
        ratingLbl.text = dto.rating == 0.0 ? "No rating" : "Rating: \(dto.rating)"
        openNowLbl.text = dto.open == true ? "Opened" : "Closed"
    }
}
