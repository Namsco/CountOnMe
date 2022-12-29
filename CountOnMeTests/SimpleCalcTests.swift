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
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        simpleCalc = SimpleCalc()
        viewController = ViewController()
    }

    func testGivenAddition_WhenHavingPlusOperator_ThenPrintingtextView(){
        simpleCalc.addNumber(number: "1")
        simpleCalc.additionOperator()
        simpleCalc.addNumber(number: "5")
        
        XCTAssert(simpleCalc.textView == "1+5")
        
    }
}
