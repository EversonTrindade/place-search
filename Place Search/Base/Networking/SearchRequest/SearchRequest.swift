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
    private var rankBy: String
    private var type: String
    private var key: String
    
    init(location: String, type: String) {
        self.location = location      
        self.type = type
        self.rankBy = BaseAPI().rankBy
        self.key = BaseAPI().key
    }
    
    func request(completion: @escaping (Places?, CustomError?) -> Void) {
        var urlComponents = URLComponents(string: BaseAPI().nearblySearch)
        urlComponents?.queryItems = [URLQueryItem(name: "location", value: location),
                                     URLQueryItem(name: "type", value: type),
                                     URLQueryItem(name: "rankby", value: rankBy),
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
            guard let places = try? JSONDecoder().decode(Places.self, from: dataFromService) else {
                completion(nil, CustomError())
                return
            }
            completion(places, nil)
            }.resume()
    }
}
