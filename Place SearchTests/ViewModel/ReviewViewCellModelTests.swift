//
//  ReviewViewCellModelTests.swift
//  Place SearchTests
//
//  Created by Everson Trindade on 30/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Place_Search

class ReviewViewCellModelTests: XCTestCase {
    
    let viewModel = ReviewViewCellModel()
    
    override func setUp() {
        super.setUp()
        guard let mock = readJSON(name: "DetailMocked"), let detail = try? JSONDecoder().decode(Detail.self, from: mock) else {
            return
        }
        viewModel.reviews = detail.result?.reviews ?? []
    }
    
    func testShouldValidateNumberOfSections() {
        XCTAssert(viewModel.numberOfSections() == 1)
    }
    
    func testShouldValidateNumberOfRowsInSection() {
        XCTAssert(viewModel.numberOfRowsInSection() == 5)
    }
    
    func testShouldValidateReviewDTO() {
        XCTAssert(viewModel.reviewDTO(index: 0).date == 1525229793)
        XCTAssert(viewModel.reviewDTO(index: 0).image == "https://lh6.googleusercontent.com/--OvzI5abkh0/AAAAAAAAAAI/AAAAAAAAAcM/wr_3C6GlvaM/s128-c0x00000000-cc-rp-mo-ba4/photo.jpg")
        XCTAssert(viewModel.reviewDTO(index: 0).name == "Ben Lee")
        XCTAssert(viewModel.reviewDTO(index: 0).rating == 5)
        XCTAssert(viewModel.reviewDTO(index: 0).review == "Oh to be a Google employee! I had no idea Google was located here until my friend suggested I meet up with him here to discuss something we were to work on. I went in as a guest and went up to the cafeteria where, just like the movie The Intern, everything was free, all the food, just like that. They really have a sublime sense of play here at Google, and an employee here literally has all one could hope for in a workspace that is actually FUN. But of course that means they expect you to work at optimum too, so well done anyone who has managed to be employed here. It is a bit Hogwarts for the doors and corridors you travel around to get to places, but with the colours and features of this place, it cannot be beat.")
        XCTAssert(viewModel.reviewDTO(index: 0).url == "https://www.google.com/maps/contrib/116907735849029125820/reviews")

    }
}
