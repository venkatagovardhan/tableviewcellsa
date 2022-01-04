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
            controller.setCardsData(mockData)
            present(controller, animated: true, completion: nil)
        }
    }
}

let mockData = [CardVO(nameOnCard: "Mahesh", last4DigitsOfAcctNo: "0001", fullCardName: "Gap Mastercard", isPrimary: true),
                CardVO(nameOnCard: "Naresh", last4DigitsOfAcctNo: "0002", fullCardName: "Gap Visacard", isPrimary: false),
                CardVO(nameOnCard: "Suresh", last4DigitsOfAcctNo: "0003", fullCardName: "Amex Card", isPrimary: true),
                CardVO(nameOnCard: "Ganesh", last4DigitsOfAcctNo: "0004", fullCardName: "Paypal Card", isPrimary: true),
                CardVO(nameOnCard: "Ramesh", last4DigitsOfAcctNo: "0005", fullCardName: "XXXX Card", isPrimary: false),
                CardVO(nameOnCard: "Venkatesh", last4DigitsOfAcctNo: "0006", fullCardName: "YYY Card", isPrimary: true)]

