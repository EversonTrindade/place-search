//
//  DetailTests.swift
//  Place SearchTests
//
//  Created by Everson Trindade on 29/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Place_Search

class DetailTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testShouldValidateDetailResult() {
        guard let mock = readJSON(name: "DetailMocked"), let place = try? JSONDecoder().decode(Detail.self, from: mock) else {
            return
        }
        
        XCTAssert(place.result?.formatted_address == "48 Pirrama Rd, Pyrmont NSW 2009, Australia")
        XCTAssert(place.result?.formatted_phone_number == "(02) 9374 4000")
        XCTAssert(place.result?.name == "Google")
        XCTAssert(place.result?.opening_hours?.open_now == false)
        XCTAssert(place.result?.rating == 4.3)
        XCTAssert(place.result?.url == "https://maps.google.com/?cid=10281119596374313554")
        XCTAssert(place.result?.website == "https://www.google.com.au/about/careers/locations/sydney/")
        
        XCTAssert(place.result?.reviews?.object(index: 0)?.author_name == "Ben Lee")
        XCTAssert(place.result?.reviews?.object(index: 0)?.author_url == "https://www.google.com/maps/contrib/116907735849029125820/reviews")
        XCTAssert(place.result?.reviews?.object(index: 0)?.language == "en")
        XCTAssert(place.result?.reviews?.object(index: 0)?.profile_photo_url == "https://lh6.googleusercontent.com/--OvzI5abkh0/AAAAAAAAAAI/AAAAAAAAAcM/wr_3C6GlvaM/s128-c0x00000000-cc-rp-mo-ba4/photo.jpg")
        XCTAssert(place.result?.reviews?.object(index: 0)?.rating == 5)
        XCTAssert(place.result?.reviews?.object(index: 0)?.relative_time_description == "4 weeks ago")
        XCTAssert(place.result?.reviews?.object(index: 0)?.text == "Oh to be a Google employee! I had no idea Google was located here until my friend suggested I meet up with him here to discuss something we were to work on. I went in as a guest and went up to the cafeteria where, just like the movie The Intern, everything was free, all the food, just like that. They really have a sublime sense of play here at Google, and an employee here literally has all one could hope for in a workspace that is actually FUN. But of course that means they expect you to work at optimum too, so well done anyone who has managed to be employed here. It is a bit Hogwarts for the doors and corridors you travel around to get to places, but with the colours and features of this place, it cannot be beat.")
        XCTAssert(place.result?.reviews?.object(index: 0)?.time == 1525229793)
    }
}
