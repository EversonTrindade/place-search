//
//  SearchRequest.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

class SearchRequest: Requestable {
    
    private var location: String
    private var radius: String
    private var type: String
    private var keyword: String
    private var key: String
    
    init(location: String, type: String, keyword: String) {
        self.location = location      
        self.type = type
        self.keyword = keyword
        self.radius = BaseAPI().radius
        self.key = BaseAPI().key
    }
    
    func request(completion: @escaping (Place?, CustomError?) -> Void) {
        var urlComponents = URLComponents(string: BaseAPI().nearblySearch)
        urlComponents?.queryItems = [URLQueryItem(name: "location", value: location),
                                     URLQueryItem(name: "type", value: type),
                                     URLQueryItem(name: "keyword", value: keyword),
                                     URLQueryItem(name: "radius", value: radius),
                                     URLQueryItem(name: "key", value: key)]
        guard let url = urlComponents?.url else {
            completion(nil, CustomError())
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error  in
            if let error = error {
                completion(nil, CustomError(error: error.localizedDescription as? Error))
                return
            }
            guard let dataFromService = data else {
                completion(nil, CustomError())
                return
            }
            guard let dogs = try? JSONDecoder().decode(Place.self, from: dataFromService) else {
                completion(nil, CustomError())
                return
            }
            completion(dogs, nil)
            }.resume()
    }
}
