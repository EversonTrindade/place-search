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
    func request(param: [String: Any], completion: @escaping (_ result: DataType?, _ error: CustomError?) -> Void)
}

struct BaseAPI {
    fileprivate let base = "https://maps.googleapis.com/maps/api/place"
    
    var nearblySearch: String {
        return "/nearbysearch" + output
    }
    
    var detail: String {
        return "/details" + output
    }
    
    var output: String {
        return "/json"
    }
}
