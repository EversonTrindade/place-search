//
//  SearchViewModelTests.swift
//  Place SearchTests
//
//  Created by Everson Trindade on 29/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import XCTest
@testable import Place_Search

class SearchViewModelTests: XCTestCase {
    
    let viewModel = SearchViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    func testShouldValidateNumberOfSections() {
        XCTAssert(viewModel.numberOfSections() == 1)
    }

    func testShouldValidateHeightForRow() {
        XCTAssert(viewModel.heightForRow() == 85.0)
    }
}
