//
//  ReviewCollectionViewCellModel.swift
//  Place Search
//
//  Created by Everson Trindade on 30/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation
import UIKit

protocol ReviewCollectionCellLoadContent: class{
    func didLoadImage()
}

protocol ReviewCollectionViewCellModelPresentable: class {
    func formatDate(date: Int) -> String
    func openUrl(authorUrl: String)
    func getImage() -> UIImage?
    func imageFromCache() -> UIImage?
}

class ReviewCollectionViewCellModel: ReviewCollectionViewCellModelPresentable {
    
    // MARK: Properties
    private weak var loadContent: ReviewCollectionCellLoadContent?
    private var imageId = ""
    private var cache = NSCache<NSString, UIImage>()
    
    init(loadContent: ReviewCollectionCellLoadContent, imageId: String) {
        self.loadContent = loadContent
        self.imageId = imageId
    }
    
    // MARK: Functions
    func formatDate(date: Int) -> String {
        let date = NSDate(timeIntervalSince1970: TimeInterval(date))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
        return dayTimePeriodFormatter.string(from: date as Date)
    }
    
    func openUrl(authorUrl: String) {
        if let url = URL(string: authorUrl) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    func getImage() -> UIImage? {
        if let imageCached = cache.object(forKey: NSString(string: imageId)) {
            return imageCached
        }
        
        let placeholder = UIImage(named: "default-placeholder")
        placeholder?.accessibilityIdentifier = "placeholder"
        cache.setObject(placeholder ?? UIImage(), forKey: NSString(string: imageId))
        
        if let url = URL(string: imageId) {
            URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cache.setObject(image, forKey: NSString(string: self.imageId))
                        self.loadContent?.didLoadImage()
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
