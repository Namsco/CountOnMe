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
// MARK: - SimpleCalc class
class SimpleCalc {

    // MARK: - Private variables
    private var result: Double = 0
    private var elementsIndex = 0
    
    private var elements: [String] {
        return textView.split(separator: " ").map { "\($0)" }
    }
    
    private var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    private var operatorIsNotAlone: Bool {
        return elements.count >= 1
    }
    
    private var textError: Bool {
        return textView == "Error"
    }
    
    // MARK: - Public variables
    weak var delegate: SimpleCalcDelegate?
    var textView = String()
    
    // MARK: - Private functions
    private func sendDataToController(data: String) {
        delegate?.didReceiveData(data)
    }
    
    private func sendAlertToController(message: String) {
        delegate?.displayAlert(message)
    }
    
    private func divisionOperation(left: Double, right: Double) -> Double{
        if left == 0 || right == 0 {
            textView = "Error"
            sendDataToController(data: textView)
            sendAlertToController(message: "You can't divide by 0 !")
        } else {
            result = left / right
            result = round(10000 * result) / 10000
        }
        return result
    }
    
    // MARK: - Public functions
    func addNumber(number: String) {
        if elements.count > 0 {
            if elements[0 + elementsIndex].contains(".") && number == "." {
                sendAlertToController(message: "You already enter a point !")
            } else {
                textView += number
                sendDataToController(data: number)
            }
        } else {
            textView += number
            sendDataToController(data: number)
        }
        if number != "." && elements.count > 1{
            elementsIndex += 1
        }
    }
    
    func addOperator(_ symbol: String) {
        guard !textError else {return sendAlertToController(message: "Please start a new calcul !")}
        let spacingOperation = " " + symbol + " "
        
        if symbol == "+" && textView == "" || symbol == "-" && textView == "" {
            textView += spacingOperation
            return sendDataToController(data: symbol)
            
        } else if symbol == "x" && textView == "" || symbol == "÷" && textView == "" {
            sendAlertToController(message: "You can't add this operator at the start of a calcul !")
            
        } else if canAddOperator && operatorIsNotAlone {
            textView += spacingOperation
            return sendDataToController(data: symbol)
            
        } else {
            sendAlertToController(message: "There already have an operator !")
        }
    }
    
    func clearTextView(){
        guard !textView.isEmpty else {return}
        elementsIndex = 0
        textView = ""
        sendDataToController(data: textView)
    }
    
    func clearLastCharacter() {
        if !textView.isEmpty {
            textView.removeLast()
            sendDataToController(data: textView)
        } else {
            elementsIndex = 0
        }
    }
    
    func calculate(){
        var operationsToReduce = elements
        
        guard expressionIsCorrect else {return sendAlertToController(message: "Entrez une expression correcte !")}
        guard expressionHaveEnoughElement else {return sendAlertToController(message: "Démarrez un nouveau calcul !")}
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var priority = 0
            
            if operationsToReduce[0] == "+" || operationsToReduce[0] == "-" {
                let newNumber = operationsToReduce[0] + operationsToReduce[1]
                operationsToReduce[0] = newNumber
                operationsToReduce.remove(at: 1)
            }
            
            if let index = operationsToReduce.firstIndex(where: {$0 == "x" || $0 == "÷"}) {
                priority = index - 1
            }
        
            guard let left = Double(operationsToReduce[priority]) else {return}
            let operand = operationsToReduce[priority + 1]
            guard let right = Double(operationsToReduce[priority + 2]) else {return}
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = divisionOperation(left: left, right: right)
            default: sendAlertToController(message: "Démarrez un nouveau calcul !")
            }
            
            for _ in 1...3 {
                operationsToReduce.remove(at: priority)
            }
            
            operationsToReduce.insert("\(result)", at: priority)
        }
        if !textError {
            elementsIndex = 0
            textView = ""
            textView.append("\(operationsToReduce.first!)")
            sendDataToController(data: textView)
        }
    }
}
