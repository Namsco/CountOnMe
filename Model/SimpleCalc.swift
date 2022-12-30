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
    func displayAlert(_ message: String)
}

class SimpleCalc {
    
    weak var delegate: SimpleCalcDelegate?
    var textView = String()
    
    var result: Double = 0.00
    
    func sendDataToController(data: String) {
        delegate?.didReceiveData(data)
        
    }
    
    func sendAlertToController(message: String) {
        delegate?.displayAlert(message)
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
        addOperator("+")
    }
    
    func substractionOperator(){
        addOperator("-")
    }
    
    func addOperator(_ symbol: String) {
        if canAddOperator {
            let spacingOperation = " " + symbol + " "
            textView += spacingOperation
            return sendDataToController(data: symbol)
        } else {
            sendAlertToController(message: "Un opérateur a déjà été mis !")
        }
    }
    
    func calculate(){
        
        var operationsToReduce = elements
        
        guard expressionIsCorrect else {return sendAlertToController(message: "Entrez une expression correcte !")}
        guard expressionHaveEnoughElement else {return sendAlertToController(message: "Démarrez un nouveau calcul !")}
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        textView.append(" = \(operationsToReduce.first!)")
        sendDataToController(data: textView)
    }
    
}
