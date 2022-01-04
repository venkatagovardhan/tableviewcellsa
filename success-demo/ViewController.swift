//
//  ViewController.swift
//  success-demo
//
//  Created by Mahesh Dhumpeti on 03/01/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tap() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "SuccessViewController") as? SuccessViewController {
            controller.customerName = "Mahesh"
            controller.cardFourDigitNum = "0004"
            controller.cardName = "Gap Mastercard"
            present(controller, animated: true, completion: nil)
        }
    }
}

