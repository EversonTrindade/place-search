//
//  FilterViewModelTests.swift
//  Place SearchTests
//
//  Created by Everson Trindade on 29/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Place_Search

class FilterViewModelTests: XCTestCase {
    
    let arrayOfTypes = ["atm", "bank", "bar"]
    
    let viewModel = FilterViewModel()
    
    override func setUp() {
        super.setUp()
        viewModel.placeTypes = arrayOfTypes
    }
  
    func testShouldValidateNumberOfSections() {
        XCTAssert(viewModel.numberOfSections() == 1)
    }
    
    func testShouldValidateNumberOfItems() {
        XCTAssert(viewModel.numberOfRowsInSection() == 3)
    }
    
    func testShouldValidateHeightForRow() {
        XCTAssert(viewModel.heightForRow() == 60.0)
    }
    
    func testShouldValidateGetPlaceType() {
        XCTAssert(viewModel.getPlaceType(row: 0) == "atm")
    }
}
