//
//  Calculator_SF_Unit_Tests.swift
//  Calculator_SF_Unit_Tests
//
//  Created by Иван Тарасенко on 21.09.2022.
//

import XCTest
@testable import Calculator_SF

class Calculator_SF_Unit_Tests: XCTestCase {

    var mut: ModelCalc!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mut = ModelCalc()

    }

    override func tearDownWithError() throws {
        mut = ModelCalc()
        try super.tearDownWithError()
    }

    func testLimitInputNumbers() throws {
        let stringOne = " twenty  characters  "
        let stringTwo = "ten charac"
        let label = UILabel()
        var count = 1

        for _ in 1...3 {

            switch mut.isTyping {
            case true:
                if count == 1 {
                    mut.limitInput(for: stringTwo, andShowIn: label)
                    XCTAssertEqual(label.txt, stringTwo)
                    label.txt.removeAll()
                    count += 1
                } else {
                    mut.limitInput(for: stringOne, andShowIn: label)
                    XCTAssertEqual(label.txt, stringOne)
                    print(label.txt)
                }
            case false:
                mut.limitInput(for: stringOne, andShowIn: label)
                XCTAssertEqual(label.txt, stringOne)
                label.txt.removeAll()
            }
        }
    }

    func testdoNotEnterZeroFirst() throws {
        let label = UILabel()
        label.text = "0"
        mut.doNotEnterZeroFirst(for: label)
        XCTAssertFalse(mut.isTyping)
    }

    func testSaveFirstOperand() throws {
        mut.saveFirstОperand(from: 42)
        XCTAssertNotNil(mut.firstOperand)
        XCTAssertEqual(mut.firstOperand, 42)
    }

    func testSaveSignOperations() throws {
        mut.saveOperation(from: "+")
        XCTAssertNotNil(mut.operation)
        XCTAssertEqual(mut.operation, "+")
    }

    func testPerformingOperation() throws {
        var currentInput = 0.0
        mut.firstOperand = 15.0
        mut.secondOperand = 10.0
        mut.operation = "+"

        for _ in 1...4 {
            switch mut.operation {
            case "+":
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 25)
                mut.operation = "-"
            case "-":
                currentInput = 0.0
                mut.firstOperand = 15.0
                mut.secondOperand = 10.0
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 5)
                mut.operation = "×"
            case "×":
                currentInput = 0.0
                mut.firstOperand = 15.0
                mut.secondOperand = 10.0
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 150)
                mut.operation = "÷"
            case "÷":
                currentInput = 0.0
                mut.firstOperand = 15.0
                mut.secondOperand = 10.0
                mut.performOperation(for: &currentInput)
                XCTAssertEqual(currentInput, 1.5)
            default:
                break
            }
        }
    }

    func testCalculatePercentage() throws {
        var currentInput = 10.0
        mut.firstOperand = 15.0
        mut.operation = "+"

        for _ in 1...4 {
            switch mut.operation {
            case "+":
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 16.5)
                mut.operation = "-"
            case "-":
                currentInput = 10.0
                mut.firstOperand = 15.0
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 13.5)
                mut.operation = "×"
            case "×":
                currentInput = 10.0
                mut.firstOperand = 15.0
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 1.5)
                mut.operation = "÷"
            case "÷":
                currentInput = 10.0
                mut.firstOperand = 15.0
                mut.calculatePercentage(for: &currentInput)
                XCTAssertEqual(currentInput, 150)
            default:
                break
            }
        }
    }

    func testEnteringFractionalNumber() throws {
        mut.isTyping = true
        mut.isDotPlaced = false
        let label = UILabel()
        label.text = "3"

        for _ in 1...2 {
            switch mut.isTyping {
            case true:
                mut.enterNumberWithDot(in: label)
                XCTAssertEqual(label.txt, "3.")
                mut.isTyping = false
                mut.isDotPlaced = false
            case false:
                mut.enterNumberWithDot(in: label)
                XCTAssertEqual(label.txt, "0.")
            }
        }
    }

    func testClearButton() throws {
        var currentValue = 42.0
        let label = UILabel()
        label.txt = "57"
        mut.firstOperand = 2.0
        mut.secondOperand = 3.0
        mut.operation = "-"
        mut.isTyping = true
        mut.isDotPlaced = true

        mut.clear(&currentValue, and: label)

        XCTAssertEqual(mut.firstOperand, 0)
        XCTAssertEqual(mut.secondOperand, 0)
        XCTAssertEqual(mut.operation, "")
        XCTAssertEqual(mut.isTyping, false)
        XCTAssertEqual(mut.isDotPlaced, false)
        XCTAssertEqual(label.txt, "0")
        XCTAssertEqual(currentValue, 0)
    }

}
