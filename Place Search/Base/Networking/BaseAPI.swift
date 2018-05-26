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
    
    var nearblySearch: String {
        return base + "/nearbysearch" + output
    }
    
    var detail: String {
        return base + "/details" + output
    }
    
    let radius = "1500"
    let key = "AIzaSyAFkpsx5UF6I4Oij77ir_k5yLWcZRPlD18"

}
