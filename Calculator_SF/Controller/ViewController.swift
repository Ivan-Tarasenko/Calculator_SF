//
//  ViewController.swift
//  Calculator_SF
//
//  Created by Иван Тарасенко on 18.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet var buttons: [UIButton]!

    let model = ModelCalc()

    var currentInput: Double {
        get {
            return Double(resultLabel.txt)!
        }
        set {
            resultLabel.txt = String(format: "%g", newValue) // Getting rid of zero in a double
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        buttomConfig(button: buttons)
    }

    func buttomConfig(button: [UIButton]) {
        for buttom in button {
            buttom.layer.cornerRadius = 15
        }
    }
    @IBAction func clearPressed(_ sender: UIButton) {
        model.clear(&currentInput, and: resultLabel)
    }

    @IBAction func reverseSingPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }

    @IBAction func procentPressed(_ sender: UIButton) {
        model.calculatePercentage(for: &currentInput)
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        model.doNotEnterZeroFirst(for: resultLabel)
        model.limitInput(for: sender.currentTitle!, andShowIn: resultLabel)
        sender.accessibilityIdentifier = "number \(String(describing: sender.titleLabel?.txt))"
        
    }

    @IBAction func operationPressed(_ sender: UIButton) {
        model.saveFirstОperand(from: currentInput)
        model.saveOperation(from: sender.currentTitle!)
    }

    @IBAction func equalityPressed(_ sender: UIButton) {
        model.performOperation(for: &currentInput)
    }

    @IBAction func sqrtPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
        model.isTyping = false
    }

    @IBAction func dotButtonPressed(_ sender: UIButton) {
        model.enterNumberWithDot(in: resultLabel)
    }
}

// MARK: - viewDidLayoutSubviews
// Color status of the bar depending on the color theme and font size title buttons
extension ViewController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 12.0, *) {
            if self.traitCollection.userInterfaceStyle == .dark {
                var preferredStatusBarStyle: UIStatusBarStyle {
                    return .lightContent
                }
            } else {
                var preferredStatusBarStyle: UIStatusBarStyle {
                    return .darkContent
                }
            }
        }
    }
}

// MARK: - viewWillTransition
// Apologies for the upper constraint in landscape mode
extension ViewController {

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isPortrait {
            topConstraint.constant = 142
        } else {
            topConstraint.constant = 10
        }
    }
}
