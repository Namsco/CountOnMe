//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet var operatorButtons: [UIButton]!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .darkContent
    }
    
    private let simpleCalcl = SimpleCalc()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleCalcl.delegate = self
        makeRoundedNumbersButtons(radius: 20)
        makeRoundedOperatorsButtons(radius: 29)
    }
    
    private func makeRoundedNumbersButtons(radius: CGFloat) {
        for buttons in numberButtons {
            buttons.layer.cornerRadius = radius
            buttons.layer.cornerCurve = .continuous
        }
        textView.layer.cornerRadius = radius
    }
    
    private func makeRoundedOperatorsButtons(radius: CGFloat){
        for buttons in operatorButtons {
            buttons.layer.cornerRadius = radius
            buttons.layer.cornerCurve = .continuous
        }
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else { return }        
        simpleCalcl.addNumber(number: numberText)
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        simpleCalcl.addOperator("+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        simpleCalcl.addOperator("-")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        simpleCalcl.addOperator("x")
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        simpleCalcl.addOperator("÷")
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        simpleCalcl.calculate()
    }
    
    @IBAction func tappedClearErrorButton(_ sender: UIButton) {
        simpleCalcl.clearTextView()
    }
    
    @IBAction func tappedClearLastCharacterButton(_ sender: UIButton) {
        simpleCalcl.clearLastCharacter()
    }
}

extension ViewController: SimpleCalcDelegate {
    
    func didReceiveData(_ data: String) {
        textView.text = simpleCalcl.textView
    }
    
    func displayAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}

