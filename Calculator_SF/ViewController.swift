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
    @IBOutlet var buttoms: [UIButton]!


    override func viewDidLoad() {
        super.viewDidLoad()
        test(buttoms: buttoms)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLayoutSubviews() {

        let landscapeRadiusButtom = CGFloat(15)
        let portraitRadiusButtom = buttoms[0].frame.width / 2
        if UIDevice.current.orientation.isLandscape {
            topConstraint.constant = 10
            for buttom in buttoms {
                buttom.layer.cornerRadius = landscapeRadiusButtom
            }
        } else {
            topConstraint.constant = 142
//            for buttom in buttoms {
//                buttom.layer.cornerRadius = portraitRadiusButtom
//            }
        }
    }

    func test(buttoms: [UIButton]) {
        for buttom in buttoms {
            buttom.layer.cornerRadius = buttom.frame.width / 2
        }
    }

    func getRadiusButtom() -> CGFloat {
        return buttoms[0].frame.width / 2
    }

}
