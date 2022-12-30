//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    var simpleCalc: SimpleCalc!
    
    override func setUp() {
        super.setUp()
        simpleCalc = SimpleCalc()

    }

    func testGivenAddition_WhenHavingPlusOperator_ThenPrintingResult(){
        simpleCalc.addNumber(number: "1")
        simpleCalc.additionOperator()
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == 11)
    }
    
    func testGivenSubstraction_WhenHavingLessOperator_ThenPrintingResult(){
        simpleCalc.addNumber(number: "8")
        simpleCalc.substractionOperator()
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        
        XCTAssert(simpleCalc.result == -2)
    }
    
    func testGivenReset_WhenHavingClearError_ThenDeleteTheTextViewContent(){
        simpleCalc.addNumber(number: "8")
        simpleCalc.substractionOperator()
        simpleCalc.addNumber(number: "10")
        simpleCalc.calculate()
        simpleCalc.clearError()
        
        XCTAssert(simpleCalc.textView == "")
    }
    
    func testGivenClear_WhenHavingClearLastCharacter_ThenDeleteTheLastCharacterIntextView(){
        simpleCalc.addNumber(number: "8")
        simpleCalc.additionOperator()
        simpleCalc.addNumber(number: "10")
        simpleCalc.clearLastCharacter()
        
        XCTAssert(simpleCalc.textView == "8 + 1")
    }
}
