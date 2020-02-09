//
//  TmdbClientUITests.swift
//  TmdbClientUITests
//
//  Created by Mauricio Figueroa olivares on 06-02-20.
//  Copyright © 2020 Mauricio Figueroa olivares. All rights reserved.
//

import XCTest

class TmdbClientUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testPresentListTvShowsAndSortTheResults() {
        app.buttons["GO"].tap()
        let sortButton = app.navigationBars["TV SHOWS"].buttons["Sort"]
        sortButton.tap()
        sortButton.tap()
    }
}
