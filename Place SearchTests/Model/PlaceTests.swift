//
//  PlaceTests.swift
//  Place SearchTests
//
//  Created by Everson Trindade on 29/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Place_Search

extension XCTestCase {
    func readJSON(name: String) -> Data? {
        let path = Bundle.main.path(forResource: name, ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        return data
    }
}

class PlaceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testShouldValidatePlaceResult() {
        guard let mock = readJSON(name: "PlaceMocked"), let place = try? JSONDecoder().decode(Places.self, from: mock) else {
            return
        }
        
        XCTAssert(place.next_page_token == "CpQCAgEAAL0w1ExT3cIJ4vIBocggFGJab1QcihVHk27VLJr7fric6_cWSuT-U1DWg4GrcQ6c-tFpTFkFzCP042q_2WtTjLfyiML6hPQKQC6Tv1yPpaMlTqQg8V7Q8LK1vnlozssd0iMf0zFkjMOQmGYp0vWHLolGz6oI8XA2-S_S72vNc9zK0aiVM22XCGB6EP4KiLTA_e_Cbj8FC0neiEl3H3mieiEagzyPupG9CumygWt0pF5b4K0TJqwFYOSdevTn5IbXXkGnO8ytM2DheUNP1ULfQT--yO2hNckASJC2yrAlb0ONiuQ5PRj5BHhQVe3cCBEbLz4B_N_2FgopauT-xikQQlUvPSYv6znKUXRHYj8VVmZhEhC8NZpIF1E4yHeykRC8w6TsGhS-y485P6fxKWYaY2-0jnd-bvI-Yg")
        XCTAssert(place.results?.object(index: 0)?.name == "Blue Hill")
        XCTAssert(place.results?.object(index: 0)?.place_id == "ChIJi9BURJFZwokRDcqvIgxdXds")
        XCTAssert(place.results?.object(index: 0)?.rating == 4.6)
        XCTAssert(place.results?.object(index: 0)?.opening_hours?.open_now == false)
        XCTAssert(place.results?.object(index: 0)?.opening_hours?.weekday_text == [])
        XCTAssert(place.results?.object(index: 0)?.geometry?.location?.lat == 40.7320465)
        XCTAssert(place.results?.object(index: 0)?.geometry?.location?.lng == -73.9996685)
    }
}
