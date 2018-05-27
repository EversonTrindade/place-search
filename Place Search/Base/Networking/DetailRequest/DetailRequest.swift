//
//  DetailRequest.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

class DetailRequest: Requestable {
    
    private var placeID: String
    private var key: String
    
    init(placeID: String) {
        self.placeID = placeID
        self.key = BaseAPI().key
    }
    
    func request(completion: @escaping (Detail?, CustomError?) -> Void) {
        var urlComponents = URLComponents(string: BaseAPI().details)
        urlComponents?.queryItems = [URLQueryItem(name: "placeid", value: placeID),
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
            guard let detail = try? JSONDecoder().decode(Detail.self, from: dataFromService) else {
                completion(nil, CustomError())
                return
            }
            completion(detail, nil)
        }.resume()
    }
}
