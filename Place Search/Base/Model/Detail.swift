//
//  Detail.swift
//  Place Search
//
//  Created by Everson Trindade on 25/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import Foundation

struct Detail: Codable {
    var result: Result?
}

struct Result: Codable {
    var formatted_address: String?
    var formatted_phone_number: String?
    var name: String?
    var opening_hours: Opening?
    var photos: [Photo]?
    var rating: Double?
    var reviews: [Review]?
    var url: String?
    var website: String?
}

struct Review: Codable {
    var author_name: String?
    var author_url: String?
    var language: String?
    var profile_photo_url: String?
    var rating: Int?
    var relative_time_description: String?
    var text: String?
    var time: Int?
}

struct Photo: Codable {
    var height: Int?
    var width: Int?
    var photo_reference: String?
}

struct Opening: Codable {
    var open_now: Bool?
    var weekday_text: [String]?
}
