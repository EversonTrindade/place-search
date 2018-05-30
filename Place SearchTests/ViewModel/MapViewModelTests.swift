//
//  MapViewModelTests.swift
//  Place SearchTests
//
//  Created by Everson Trindade on 29/05/18.
//  Copyright © 2018 Everson Trindade. All rights reserved.
//

import CoreLocation
import XCTest
@testable import Place_Search

class MapViewModelTests: XCTestCase {
    
    let viewModel = MapViewModel()
    
    override func setUp() {
        super.setUp()
    }
    
    func testShouldValidateGetLocation() {
        let coordinate = CLLocationCoordinate2D(latitude: -33.8670522, longitude: 151.1957362)
        XCTAssert(viewModel.getLocation(coordinate: coordinate) == "-33.8670522,151.1957362")
    }
    
    func testShouldValidateCheckIfIsClosed() {
        XCTAssert(viewModel.checkIfIsClosed(open: true) == " - Open")
    }
    
    func testShouldValidateGetDist() {
        XCTAssert(viewModel.getDist(CLLocationCoordinate2D(latitude: -23.513536761990508, longitude: -46.688068228940153), CLLocationCoordinate2D(latitude: -23.5208464, longitude: -46.700928699999999)) == "1.54")
    }
    
}
