//
//  Zozor_UITests.swift
//  CountOnMeUITests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest

class Zozor_UITests: XCTestCase {

    var app: XCUIApplication = XCUIApplication()

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCalcul() {
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.textViews["10+9=19"].exists, "Test calcul Failed")
    }

    func testMemorise() {
        testCalcul()
        app.buttons["M"].tap()
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        app.buttons["+"].tap()
        app.buttons["MR"].tap()
        app.buttons["="].tap()
        XCTAssertTrue(app.textViews["10+19=29"].exists, "Test calcul Failed")
    }
}
