//
//  Place.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

struct Places: Codable {
    var next_page_token: String?
    var results: [Place]?
}

struct Place: Codable {
    var name: String?
    var place_id: String?
    var rating: Double?
    var opening_hours: Opening?
    var photos: [Photo]?
    var geometry: Geometry?
}

struct Geometry: Codable {
    var location: Location?
}

struct Location: Codable {
    var lat: Double?
    var lng: Double?
}

struct Opening: Codable {
    var open_now: Bool?
    var weekday_text: [String]?
}

struct Photo: Codable {
    var height: Int?
    var width: Int?
    var photo_reference: String?
}
