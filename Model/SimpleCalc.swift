//
//  SimpleCalc.swift
//  CountOnMe
//
//  Created by Zidouni on 19/12/2022.
//  Copyright © 2022 Vincent Saluzzo. All rights reserved.
//

import Foundation

// MARK: - Protocol
protocol SimpleCalcDelegate: AnyObject {
    func didReceiveData(_ data: String)
}

class SimpleCalc {
    
    weak var delegate: SimpleCalcDelegate?
    var textView = String()
    
    func sendDataToController(data: String) {
        delegate?.didReceiveData(data)
        
    }
    
    var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    
    var expressionHaveResult: Bool {
        return textView.firstIndex(of: "=") != nil
    }
    
    func addNumber(number: String) {
        if expressionHaveResult {
            textView = ""
        } else {
            textView += number
            sendDataToController(data: number)
        }
    }
    
    func additionOperator(){
        textView.append("+")
    }
    
}
