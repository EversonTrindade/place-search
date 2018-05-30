//
//  DetailViewCell.swift
//  Place Search
//
//  Created by Everson Trindade on 27/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import UIKit

struct DetailViewCellDTO {
    var image = ""
    var name = ""
    var phone = ""
    var address = ""
    var url = ""
}

class DetailViewCell: UITableViewCell, DetailViewCellLoadContent {

    // MARK: IBOutlet
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placePhone: UILabel!
    @IBOutlet weak var placeAddress: UILabel!
    
    // MARK Properties
    private var detailDTO: DetailViewCellDTO?
    lazy var viewModel: DetailViewCellModelPresentable = DetailViewCellModel(delegate: self, imageId: self.detailDTO?.image ?? "")
    
    // MARK: Function
    func fillCell(dto: DetailViewCellDTO) {
        detailDTO = dto
        placeName.text = dto.name
        placePhone.text = dto.phone
        placeAddress.text = dto.address
        placeImage.image = viewModel.getImage()
    }
    
    // MARK: IBAction
    @IBAction func moreInfoAction(_ sender: Any) {
        if let url = URL(string: detailDTO?.url ?? "") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // MARK: DetailViewCellLoadContent
    func didLoadImage() {
        placeImage.image = viewModel.imageFromCache()
    }
}
