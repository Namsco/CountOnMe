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

    // MARK: - Test Errors
    func testGivenDivision_WhenTryingToDiviseByZero_ThenPrintError() {
        simpleCalc.addNumber(number: "0")
        simpleCalc.addOperator("÷")
        simpleCalc.addNumber(number: "4")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.textView == "Error")
    }
    
    func testGivenAddNumber_WhenTextIsError_ThenSendAlert() {
        simpleCalc.textView = "Error"
        simpleCalc.addNumber(number: "3")
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "Please start a new calcul !")
    }

    func testGivenDecimal_WhenTryToAddTwoPoint_ThenPrintAlertMessage() {
        simpleCalc.addNumber(number: ".")
        simpleCalc.addNumber(number: ".")
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "You already enter a point !")
    }
    
    func testGivenAddOperator_WhenTextViewIsEqualAtError_ThenSendAnAlert() {
        simpleCalc.textView = "Error"
        simpleCalc.addOperator("+")
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "Please start a new calcul !")
        
    }
    
    func testGivenAddOperator_WhenAlreadyHaveAnOperator_ThenSendAnAlert() {
        simpleCalc.addNumber(number: "5")
        simpleCalc.addOperator("x")
        simpleCalc.addOperator("x")
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "There already have an operator !")
    }
    
    func testGivenAddedMultiplyOperator_WhenStartingACalcul_ThenSendAnAlert() {
        simpleCalc.addOperator("x")
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "You can't add this operator at the start of a calcul !")
    }
    
    func testGivenAddedDivisionOperator_WhenStartingACalcul_ThenSendAnAlert() {
        simpleCalc.addOperator("÷")
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "You can't add this operator at the start of a calcul !")
    }
    
    func testGivenClearTextView_WhenTextViewIsEmpty_ThenSendAlert() {
        simpleCalc.clearTextView()
    
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "There are no content to remove !")
        
    }
    
    func testGivenClearLastCharacter_WhenTextIsError_ThenSendAlert() {
        simpleCalc.textView = "Error"
        simpleCalc.clearLastCharacter()
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "Please start a new calcul !")
    }
    
    func testGivenClearLastCharacter_WhenTextViewIsEmpty_ThenSendAlert() {
        simpleCalc.clearLastCharacter()
    
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "There are no content to remove !")
        
    }
    
    func testGivenCalculate_WhenExpressionIsntCorrect_ThenSendAnAlert() {
        simpleCalc.addNumber(number: "4")
        simpleCalc.addOperator("x")
        simpleCalc.calculate()
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "Please enter a correct expression !")
    }
    
    func testGivenCalculate_WhenExpressionHaventEnoughElement_ThenSendAnAlert() {
        simpleCalc.calculate()
        
        XCTAssertEqual(simpleCalc.result == 0.0, simpleCalc.messageTest == "Your expression isn't correct, please enter more elements !")
    }
    
    func testGivenCalculate_WhenHavingDecimalNumber_ThenCommaIsReplacedByADot() {
        simpleCalc.addNumber(number: "1.5")
        simpleCalc.addOperator("+")
        simpleCalc.addNumber(number: "15")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.textView == "16.5")
    }
}
