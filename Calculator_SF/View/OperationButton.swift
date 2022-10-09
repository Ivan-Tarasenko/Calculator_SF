//
//  OperationButton.swift
//  Calculator_SF
//
//  Created by Иван Тарасенко on 09.10.2022.
//

import UIKit

class OperationButton: UIButton {

    override open var isHighlighted: Bool {
             didSet {
                 backgroundColor = isHighlighted ? #colorLiteral(red: 0.7138285041, green: 0.4184841514, blue: 0.04907315224, alpha: 1) : #colorLiteral(red: 0.998134315, green: 0.5796165466, blue: 0, alpha: 1)
             }
         }
}
