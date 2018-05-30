//
//  DetailViewModelTests.swift
//  Place SearchTests
//
//  Created by Everson Trindade on 30/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Place_Search

class DetailViewModelTests: XCTestCase {
    
    let viewModel = DetailViewModel()
    
    override func setUp() {
        super.setUp()
        guard let mock = readJSON(name: "DetailMocked"), let detail = try? JSONDecoder().decode(Detail.self, from: mock) else {
            return
        }
        viewModel.detail = detail
    }
    
    func testShouldValidateNumberOfSections() {
        XCTAssert(viewModel.numberOfSections() == 1)
    }
    
    func testShouldValidateNumberOfRowsInSection() {
        XCTAssert(viewModel.numberOfRowsInSection() == 2)
    }
    
    func testShouldValidateHeigthForRow() {
        XCTAssert(viewModel.heightForRow() == 276.0)
    }
    
    func testShouldValidateGetDetails() {
        XCTAssert(viewModel.getDetails(index: 0).address == "48 Pirrama Rd, Pyrmont NSW 2009, Australia")
        XCTAssert(viewModel.getDetails(index: 0).image == "CmRaAAAAZLpTEb4elv6PwvQn0szqpbmEzLo__WEioBrasf7BePEOthpZrth7XVVwRh6Bq3eOjrojE69ayJg9TLTwyZV3aUmZi-_gDsyJgFObH7N6Ta-fs6gZHDBTbdkBub9UZu6ZEhBsuTAmWIwpMDoDj8Q_w0bbGhQ13CBBL6mFU5g2kIssmuy87ujlFg")
        XCTAssert(viewModel.getDetails(index: 0).name == "Google")
        XCTAssert(viewModel.getDetails(index: 0).phone == "(02) 9374 4000")
        XCTAssert(viewModel.getDetails(index: 0).url == "https://maps.google.com/?cid=10281119596374313554")
    }
}
