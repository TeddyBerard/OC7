//
//  Calculator.swift
//  CountOnMe
//
//  Created by Teddy Bérard on 09/04/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

protocol CalculatorProtocol: class {
    
    func updateDisplay()
    func showAlert(title: String, message: String, titleAction: String)
}

class Calculator {

    // MARK: - Properties
    
    weak var calculatorDelegate: CalculatorProtocol?
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    
    // MARK: - Initialization
    
    init() {}
    
    // MARK: - Method
    
    
    /// Calcul the total
    ///
    /// - Returns: return the total value of calcul
    func calculateTotal() -> Int {
        var total = 0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Int(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }
        
        clear()
        return total
    }
    
    /// Add number to stringNumber array
    ///
    /// - Parameter newNumber: number will be add to stringNumbers
    func addNewNumber(_ newNumber: Int) {
        if let stringNumber = stringNumbers.last {
            var stringNumberMutable = stringNumber
            stringNumberMutable += "\(newNumber)"
            stringNumbers[stringNumbers.count-1] = stringNumberMutable
        }
        calculatorDelegate?.updateDisplay()
    }
    
    /// Get the calcul and return this calcul
    ///
    /// - Returns: The calcul with operators and numbers
    func getDisplay() -> String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        return text
    }
    
    /// Add + to the calcul
    func addPlus() {
        if canAddOperator() {
            operators.append("+")
            stringNumbers.append("")
            calculatorDelegate?.updateDisplay()
        }
    }
    
    /// Add - to the calcul
    func addMinus() {
        if canAddOperator() {
            operators.append("-")
            stringNumbers.append("")
            calculatorDelegate?.updateDisplay()
        }
    }
    
    /// clear the calcul
    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }
    
    /// Detect if the expression is correct
    ///
    /// - Returns: true if the expression is correct otherwise false
    func isExpressionCorrect() -> Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                if stringNumbers.count == 1 {
                    calculatorDelegate?.showAlert(title: Const.Title.zero, message: Const.Message.startNewCalcul, titleAction: Const.TitleAction.ok)
                } else {
                    calculatorDelegate?.showAlert(title: Const.Title.zero, message: Const.Message.enterCorrectCalcul, titleAction: Const.TitleAction.ok)
                }
                return false
            }
        }
        return true
    }
    
    /// Detect if we can add operator to the calcul
    ///
    /// - Returns: return true if we can add operator otherwise false
    func canAddOperator() -> Bool {
        if let stringNumber = stringNumbers.last {
            if stringNumber.isEmpty {
                calculatorDelegate?.showAlert(title: Const.Title.zero, message: Const.Message.wrongExpression, titleAction: Const.TitleAction.ok)
                return false
            }
        }
        return true
    }
}
