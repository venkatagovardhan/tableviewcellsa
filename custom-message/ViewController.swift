//
//  ViewController.swift
//  custom-message
//
//  Created by Mahesh Dhumpeti on 29/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var messageComponent: UCCustomMessage2!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageComponent.label = "This is a pre-authorized transaction that will continue to bill until the merchant receives a cancelation."
        messageComponent.titleLabel.text = "If you haven’t already canceled"
        messageComponent.textColor = UIColor.red
        messageComponent.titleColor = UIColor.darkGray
        messageComponent.titleFont = UIFont.systemFont(ofSize: 21)
        messageComponent.viewBgColor = UIColor.gray
        messageComponent.borderColor = UIColor.blue
        messageComponent.borderWidth = 1.0
        messageComponent.borderRadius = 8.0
        messageComponent.messageType = MessageType.alertWithButton
        messageComponent.messageStyle = MessageStyle.error
    }
    
    
}

