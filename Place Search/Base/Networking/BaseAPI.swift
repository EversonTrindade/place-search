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

//https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+Sydney&key=AIzaSyAFkpsx5UF6I4Oij77ir_k5yLWcZRPlD18


//https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-23.5135871938739,-46.6879204156&type=art_gallery&rankby=distance&key=AIzaSyAFkpsx5UF6I4Oij77ir_k5yLWcZRPlD18

struct BaseAPI {
    fileprivate let base = "https://maps.googleapis.com/maps/api/place"
    fileprivate let output = "/json"
    let rankBy = "distance"
    let key = "AIzaSyAFkpsx5UF6I4Oij77ir_k5yLWcZRPlD18"
    
    var nearblySearch: String {
        return base + "/nearbysearch" + output
    }
    
    var details: String {
        return base + "/details" + output
    }
    
    var textSearch: String {
        return base + "/textsearch" + output
    }
}
