//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class Zozor_Tests: XCTestCase {

    var calculator: Calculator!

    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    override func tearDown() {
        super.tearDown()
    }

    func rand() -> Int {
        return Int.random(in: 1..<100)
    }

    func testCalculTotal() {
        calculator.stringNumbers = ["20", "4", "5", "2"]
        calculator.operators = ["+", "+", "+", "-"]

        XCTAssertEqual(calculator.calculateTotal(), 27)
    }

    func testMemorise() {
        calculator.stringNumbers = ["20", "4", "5", "2"]
        calculator.operators = ["+", "+", "+", "-"]

        _ = calculator.calculateTotal()
        calculator.saveMemorise()

        XCTAssertEqual(calculator.memorise, "27")
    }

    func testResetMemorise() {
        testMemorise()

        calculator.resetMemorise()
        XCTAssertEqual(calculator.memorise, nil)
    }

    func testAddNewNumber() {
        let rand = self.rand()

        calculator.addNewNumber(rand)

        XCTAssertEqual(calculator.stringNumbers.last, String(rand))
    }

    func testAddPlus() {
        testAddNewNumber()
        calculator.operators = []

        calculator.addPlus()
        XCTAssertEqual(calculator.operators.last, "+")
    }

    func testAddMinus() {
        testAddNewNumber()
        calculator.operators = []

        calculator.addMinus()
        XCTAssertEqual(calculator.operators.last, "-")
    }

    func testStartNewCalcul() {
        XCTAssertEqual(calculator.isExpressionCorrect(), false)
    }

    func testEnterCorrectCalcul() {
        calculator.stringNumbers = ["5", ""]
        XCTAssertEqual(calculator.isExpressionCorrect(), false)
    }

    func testCanAddOperator() {
        calculator.operators = ["-", "-", "+"]

        XCTAssertEqual(calculator.canAddOperator(), false)
    }

    func testAddMemorise() {
        testMemorise()
        calculator.addMemorise()

        XCTAssertEqual(calculator.stringNumbers.last, "27")
    }

    func testGetDisplay() {
        calculator.stringNumbers = ["20", "4", "5", "2"]
        calculator.operators = ["+", "+", "+", "-"]

        XCTAssertEqual(calculator.getDisplay(), "20+4+5-2")
    }
}
