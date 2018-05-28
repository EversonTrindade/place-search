//
//  FilterViewCell.swift
//  Place Search
//
//  Created by Everson Trindade on 28/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

class FilterViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    func fillCell(title: String) {
        titleLbl.text = title.formatFilterValue()
    }
}
