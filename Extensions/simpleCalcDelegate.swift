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
    
    // Function to receive model's textView and give his data to controller's textView.
    func didReceiveData(_ data: String) {
        textView.text = simpleCalcl.textView
    }
    
    // Function who has the logic of UIAlertController. 
    func displayAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Zéro!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
