//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Property
    
    var calculator: Calculator = Calculator()

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var memoriseButton: UIButton!
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculator.calculatorDelegate = self
    }
    
    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        for (i, numberButton) in numberButtons.enumerated() {
            if sender == numberButton {
                calculator.addNewNumber(i)
            }
        }
    }

    @IBAction func plus() {
        calculator.addPlus()
    }

    @IBAction func minus() {
        calculator.addMinus()
    }

    @IBAction func equal() {
        displayResult()
    }
    
    @IBAction func memorise(_ sender: Any) {
        if calculator.memorise == nil {
            calculator.saveMemorise()
            
            if let memorise = calculator.memorise,
                !memorise.isEmpty {
                memoriseButton.setTitle(Const.TitleButton.removeMemorise, for: .normal)
            }
        } else {
            calculator.resetMemorise()
            memoriseButton.setTitle(Const.TitleButton.saveMemorise, for: .normal)
        }
    }
    
    
    @IBAction func writeMemorise(_ sender: Any) {
        calculator.addMemorise()
    }
    
    // MARK: - Utils
    
    func displayResult() {
        guard calculator.isExpressionCorrect() else { return }
        
        textView.text += "=\(calculator.calculateTotal())"
    }
    
}

extension ViewController: CalculatorProtocol {
    
    /// Update the textView with the Calculator calcul
    func updateDisplay() {
        textView.text = calculator.getDisplay()
    }
    
    /// Display alert with specific parameters
    ///
    /// - Parameters:
    ///   - title: UIAlertController title
    ///   - message: UIAlertController message
    ///   - titleAction: UIAlertAction title
    func showAlert(title: String, message: String, titleAction: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: titleAction, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
