//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

// MARK: - Test for SimplCalc class
class SimpleCalcTests: XCTestCase {
    
    var simpleCalc: SimpleCalc!
    
    override func setUp() {
        super.setUp()
        simpleCalc = SimpleCalc()
    }

    // MARK: - Test for functions call by buttons
    func testGivenAddition_WhenHavingPlusOperator_ThenPrintingResult() {
        simpleCalc.addNumber(number: "1")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 11)
    }
    
    func testGivenSubstraction_WhenHavingLessOperator_ThenPrintingResult() {
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("-")
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == -2)
    }
    
    func testGivenMultiplication_WhenHavingMultiplyOperator_ThenPrintingResult() {
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("x")
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 80)
    }
    
    func testGivenDivision_WhenHavingDivisionOperator_ThenPrintingResult() {
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("÷")
        simpleCalc.addNumber(number: "4")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 2)
    }
    
    func testGivenClearTextView_WhenHavingAContent_ThenDeletingTheTextViewContent() {
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("-")
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        simpleCalc.clearTextView()
        
        XCTAssert(simpleCalc.textView == "")
    }
    
    func testGivenClearLastCharacter_WhenHavingAContent_ThenDeletingTheLastCharacterInsideTheTextView() {
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "10")
        simpleCalc.clearLastCharacter()
        
        XCTAssert(simpleCalc.textView == "8 + 1")
    }
    
    // MARK: - Test some possibilities inside the calcul
    
    func testGivenNewCalcul_WhenUsingANewOperatorAfterACalcul_ThenStartANewCalculWithTheLastResult() {
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        simpleCalc.addOperator("+")
        
        XCTAssert(simpleCalc.textView == "18 + ")
    }
    
    func testGivenCalculate_WhenTheFirstNumberIsNegative_ThenPrintResult() {
        simpleCalc.addOperator("-")
        simpleCalc.addNumber(number: "2")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "5")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 3)
    }
    
    func testGivenCalculate_WhenHavingMultiplicationPriority_ThenPrintResult() {
        simpleCalc.addNumber(number: "5")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("x")
        simpleCalc.addNumber(number: "2")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 21)
    }
    
    func testGivenCalculate_WhenHavingDivisionPriority_ThenPrintResult() {
        simpleCalc.addNumber(number: "5")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "8")
        simpleCalc.addOperator("÷")
        simpleCalc.addNumber(number: "2")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 9)
    }
    
    func testGivenCalculate_WhenHavingDecimalNumber_ThenCommaIsReplacedByADot() {
        simpleCalc.addNumber(number: "1.5")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "15")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 16.5)
    }
    
    func testGivenCalculate_WhenHavingSomeDecimalNumbers_ThenPrintResult() {
        simpleCalc.addNumber(number: "5.4")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "5.467")
        simpleCalc.addOperator("x")
        simpleCalc.addNumber(number: "3.41")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 24.04247)
    }
    
    func testGivenCalculate_ChenHavingSomeOperators_ThenPrintResult() {
        simpleCalc.addOperator("-")
        simpleCalc.addNumber(number: "2")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "9")
        simpleCalc.addOperator("x")
        simpleCalc.addNumber(number: "2")
        simpleCalc.addOperator("÷")
        simpleCalc.addNumber(number: "5")
        simpleCalc.addOperator("-")
        simpleCalc.addNumber(number: "2")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.textView == "-0.4")
    }
    
    func testGivenCalculate_WhenHavingBigNumbers_ThenPrintResult() {
        simpleCalc.addNumber(number: "12893")
        simpleCalc.addOperator("x")
        simpleCalc.addNumber(number: "123.67")
        simpleCalc.addOperator("-")
        simpleCalc.addNumber(number: "2389.928")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "3638293")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 5230380.382)
    
    }

    // MARK: - Test Errors
    func testGivenDivision_WhenTryingToDiviseByZero_ThenPrintError() {
        simpleCalc.addNumber(number: "4")
        simpleCalc.addOperator("÷")
        simpleCalc.addNumber(number: "0")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.textView == "Error")
    }
    
    func testGivenDivision_WhenTryingToDiviseZero_ThenPrintResult() {
        simpleCalc.addNumber(number: "0")
        simpleCalc.addOperator("÷")
        simpleCalc.addNumber(number: "4")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 0)
    }
    
    
    func testGivenAddNumber_WhenTextIsError_ThenSendAlert() {
        simpleCalc.textView = "Error"
        simpleCalc.addNumber(number: "3")
        
        XCTAssertTrue(simpleCalc.messageTest == "Please start a new calcul !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }

    func testGivenDecimal_WhenTryToAddTwoPoint_ThenPrintAlertMessage() {
        simpleCalc.addNumber(number: ".")
        simpleCalc.addNumber(number: ".")
        
        XCTAssertTrue(simpleCalc.messageTest == "You already enter a point !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }
    
    func testGivenAddOperator_WhenTextViewIsEqualAtError_ThenSendAnAlert() {
        simpleCalc.textView = "Error"
        simpleCalc.addOperator("+")
        
        XCTAssertTrue(simpleCalc.messageTest == "Please start a new calcul !")
        XCTAssertEqual(simpleCalc.result, 0.0)
        
    }
    
    func testGivenAddOperator_WhenAlreadyHaveAnOperator_ThenSendAnAlert() {
        simpleCalc.addNumber(number: "5")
        simpleCalc.addOperator("x")
        simpleCalc.addOperator("x")
        
        XCTAssertTrue(simpleCalc.messageTest == "There already have an operator !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }
    
    func testGivenAddedMultiplyOperator_WhenStartingACalcul_ThenSendAnAlert() {
        simpleCalc.addOperator("x")
        
        XCTAssertTrue(simpleCalc.messageTest == "You can't add this operator at the start of a calcul !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }
    
    func testGivenAddedDivisionOperator_WhenStartingACalcul_ThenSendAnAlert() {
        simpleCalc.addOperator("÷")
        
        XCTAssertTrue(simpleCalc.messageTest == "You can't add this operator at the start of a calcul !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }
    
    func testGivenClearTextView_WhenTextViewIsEmpty_ThenSendAlert() {
        simpleCalc.clearTextView()
    
        XCTAssertTrue(simpleCalc.messageTest == "There are no content to remove !")
        XCTAssertEqual(simpleCalc.result, 0.0)
        
    }
    
    func testGivenClearLastCharacter_WhenTextIsError_ThenSendAlert() {
        simpleCalc.textView = "Error"
        simpleCalc.clearLastCharacter()
        
        XCTAssertTrue(simpleCalc.messageTest == "Please start a new calcul !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }
    
    func testGivenClearLastCharacter_WhenTextViewIsEmpty_ThenSendAlert() {
        simpleCalc.clearLastCharacter()
    
        XCTAssertTrue(simpleCalc.messageTest == "There are no content to remove !")
        XCTAssertEqual(simpleCalc.result, 0.0)
        
    }
    
    func testGivenCalculate_WhenExpressionIsntCorrect_ThenSendAnAlert() {
        simpleCalc.addNumber(number: "4")
        simpleCalc.addOperator("x")
        simpleCalc.calculate()
        
        XCTAssertTrue(simpleCalc.messageTest == "Please enter a correct expression !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }
    
    func testGivenCalculate_WhenExpressionHaventEnoughElement_ThenSendAnAlert() {
        simpleCalc.calculate()
        
        XCTAssertTrue(simpleCalc.messageTest == "Your expression isn't correct, please enter more elements !")
        XCTAssertEqual(simpleCalc.result, 0.0)
    }
}
