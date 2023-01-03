//
//  removeZerosFromEnd.swift
//  CountOnMe
//
//  Created by Zidouni on 03/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension Double {
    // Function to remove the .0 inside the number if it has no more number after it.
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        return String(formatter.string(from: number) ?? "")
    }
}
