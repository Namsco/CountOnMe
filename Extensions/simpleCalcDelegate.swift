//
//  simpleCalcDelegate.swift
//  CountOnMe
//
//  Created by Zidouni on 03/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

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
