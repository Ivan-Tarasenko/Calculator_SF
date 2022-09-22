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
            return Double(resultLabel.txt) ?? 0
        }
        set {
            let value = "\(newValue)"   // Getting rid of zero in a double
            let valueArrey = value.components(separatedBy: ".")
            if valueArrey[1] == "0" {
                resultLabel.txt = "\(valueArrey[0])"
            } else {
                resultLabel.txt = "\(newValue)"
            }
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
//        setFontSize()
        setColorStatusBar()
    }

    func setColorStatusBar() {
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

    func setFontSize() {
        if UIDevice.current.orientation.isPortrait {
            for buttom in buttons {
                buttom.titleLabel?.font = UIFont.systemFont(ofSize: 27)
            }
        } else {
            for buttom in buttons {
                buttom.titleLabel?.font = UIFont.systemFont(ofSize: 20)
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

    override func viewWillLayoutSubviews() {

    }
}
