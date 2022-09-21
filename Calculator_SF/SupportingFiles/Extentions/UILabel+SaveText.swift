//
//  UILabel+SaveText.swift
//  Calculator_SF
//
//  Created by Иван Тарасенко on 20.09.2022.
//

import UIKit

extension UILabel {

    var txt: String {
        get {
            return text ?? ""
        }
        set {
            text = newValue
        }
    }
}
