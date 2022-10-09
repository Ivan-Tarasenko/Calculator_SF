//
//  CustomButton.swift
//  Calculator_SF
//
//  Created by Иван Тарасенко on 09.10.2022.
//

import UIKit

class NumberButton: UIButton {

    override open var isHighlighted: Bool {
             didSet {
                 backgroundColor = isHighlighted ? #colorLiteral(red: 0.4268798232, green: 0.3156888485, blue: 0.03422728181, alpha: 1) : #colorLiteral(red: 0.6783229113, green: 0.4985608459, blue: 0, alpha: 1)
             }
         }
}
