//
//  BaseAPI.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

protocol Requestable: class {
    associatedtype DataType
    func request(completion: @escaping (_ result: DataType?, _ error: CustomError?) -> Void)
}

struct BaseAPI {
    fileprivate let base = "https://maps.googleapis.com/maps/api/place"
    fileprivate let output = "/json"
    let rankBy = "distance"
    let key = "AIzaSyDUyxhRApH8EBcDFWmXqpjy60XfwDjc3XM"
    
    var nearblySearch: String {
        return base + "/nearbysearch" + output
    }
    
    var details: String {
        return base + "/details" + output
    }
    
    var textSearch: String {
        return base + "/textsearch" + output
    }
    
    var photo: String {
        return base + "/photo"
    }
    
}
