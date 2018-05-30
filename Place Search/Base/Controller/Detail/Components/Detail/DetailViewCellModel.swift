//
//  DetailViewCellModel.swift
//  Place Search
//
//  Created by Everson Trindade on 30/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewCellLoadContent: class {
    func didLoadImage()
}

protocol DetailViewCellModelPresentable: class {
    func getImage() -> UIImage?
    func imageFromCache() -> UIImage?
}

class DetailViewCellModel: DetailViewCellModelPresentable {
    
    // MARK: Properties
    private var cache = NSCache<NSString, UIImage>()
    private weak var loadContentDelegate: DetailViewCellLoadContent?
    private var imageId = ""
    
    init(delegate: DetailViewCellLoadContent, imageId: String) {
        self.loadContentDelegate = delegate
        self.imageId = imageId
    }
    
    // MARK: Functions
    func getImage() -> UIImage? {
        if let imageCached = cache.object(forKey: NSString(string: imageId)) {
            return imageCached
        }
        
        let placeholder = UIImage(named: "default-placeholder")
        placeholder?.accessibilityIdentifier = "placeholder"
        cache.setObject(placeholder ?? UIImage(), forKey: NSString(string: imageId))
        
        var urlComponents = URLComponents(string: BaseAPI().photo)
        urlComponents?.queryItems = [URLQueryItem(name: "maxwidth", value: "400"),
                                     URLQueryItem(name: "key", value: BaseAPI().key),
                                     URLQueryItem(name: "photoreference", value: imageId)]
        if let url = urlComponents?.url {
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cache.setObject(image, forKey: NSString(string: self.imageId))
                        self.loadContentDelegate?.didLoadImage()
                    }
                }
            }).resume()
        }
        return nil
    }
    
    func imageFromCache() -> UIImage? {
        return cache.object(forKey: NSString(string: imageId))
    }
}
