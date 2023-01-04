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
    var result: Double = 0
    private var elementsIndex: Int!
    
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
    
    private var textIsError: Bool {
        return textView != "Error"
    }
    
    // MARK: - Public variables
    weak var delegate: SimpleCalcDelegate? // For pass data to controller.
    var textView = String() // For pass this textView data's to controller.
    
    // MARK: - Private functions
    func sendDataToController(data: String) {
        delegate?.didReceiveData(data)
    }
    
    func sendAlertToController(message: String) {
        delegate?.displayAlert(message)
    }
    
    // We created a divisionOperation function to control if the number is divide by 0.
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
        elementsIndex = elements.count - 1 // To control the dot when we have a decimal number, we must created pass a value for element's index, this is always equal to elements.count - 1.
        guard textIsError else {return sendAlertToController(message: "Please start a new calcul !")}

        if elements.count > 0 { // If we add an operator before a number, elements.count is > 0.
            if elements[elementsIndex].contains(".") && number == "." { // We control if user add "." when the number is already a decimal number.
                sendAlertToController(message: "You already enter a point !")
            } else {
                textView += number
                sendDataToController(data: number)
            }
        } else {
            textView += number
            sendDataToController(data: number)
        }
    }
    
    func addOperator(_ symbol: String) {
        guard textIsError else {return sendAlertToController(message: "Please start a new calcul !")}
        let spacingOperation = " " + symbol + " " // We add space to the operation for more visibility.
        
        if symbol == "+" && textView == "" || symbol == "-" && textView == "" { // We can add "+" or "-" operator if textView is Empty.
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
        guard !textView.isEmpty else {return sendAlertToController(message: "There are no content to remove !")}
        textView = ""
        sendDataToController(data: textView)
    }
    
    func clearLastCharacter() {
        guard textIsError else {return sendAlertToController(message: "Please start a new calcul !")}
        if !textView.isEmpty { // We control if text is not empty, if it isn't, we can remove last character inside the textView.
            textView.removeLast()
            sendDataToController(data: textView)
        } else {
            sendAlertToController(message: "There are no content to remove !")
        }
    }
    
    func calculate(){
        var operationsToReduce = elements
        
        guard expressionIsCorrect else {return sendAlertToController(message: "Please enter a correct expression !")}
        guard expressionHaveEnoughElement else {return sendAlertToController(message: "Please start a new calcul !")}
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var priority = 0 // For control the priority inside the calcul.
            
            if operationsToReduce[0] == "+" || operationsToReduce[0] == "-" { // If the first operator is equal to "+" or "-", we fusion it with the next number inside the array.
                let newNumber = operationsToReduce[0] + operationsToReduce[1]
                operationsToReduce[0] = newNumber
                operationsToReduce.remove(at: 1) // After the fusion we remove the element at the index 1.
            }
            
            if let index = operationsToReduce.firstIndex(where: {$0 == "x" || $0 == "÷"}) {
                priority = index - 1 // We define priority's value as the index when we have multiplication or division operator - 1, to find index of the first number of the priority operation.
            }
            
            let left = Double(operationsToReduce[priority])!
            let operand = operationsToReduce[priority + 1]
            let right = Double(operationsToReduce[priority + 2])!
            
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = divisionOperation(left: left, right: right)
            default: sendAlertToController(message: "Démarrez un nouveau calcul !")
            }
            
            for _ in 1...3 {
                operationsToReduce.remove(at: priority) // After the priority operation we remove numbers of this last.
            }
            let newResult = result.removeZerosFromEnd() // We create a new property to call the extension for remove .0 when it isn't following by an other number different from 0.
            var resultWithDot = String()
            if newResult.contains(","){
                resultWithDot = newResult.replacingOccurrences(of: ",", with: ".") // Inside the newResult we replace the "," to a ".".
            } else {
                resultWithDot = newResult
            }
            
            operationsToReduce.insert("\(resultWithDot)", at: priority)
            
            if textIsError { // We control if the textView is equal at "Error"
                textView = ""
                textView.append("\(operationsToReduce.first!)")
                sendDataToController(data: textView)
            }
        }
    }
}
