//
//  SuccessViewController.swift
//  success-demo
//
//  Created by Mahesh Dhumpeti on 04/01/22.
//

import UIKit

class SuccessViewController: UIViewController {

    @IBOutlet weak var successImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var cardContainerView: UIView!
    @IBOutlet weak var cardNumLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    
    @IBOutlet weak var continueBtn: UIButton!
    
    var customerName: String = ""
    var cardFourDigitNum: String = ""
    var cardName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    private func setupUI() {
        headerLabel.text = "Your card is ready to use."
        messageLabel.text = "The following card has been activated."
        
        cardContainerView.layer.cornerRadius = 4.0
        cardContainerView.layer.borderWidth = 1.0
        cardContainerView.layer.borderColor = UIColor.gray.cgColor
        
        cardNumLabel.text = String(format: "%@...%@", cardName, cardFourDigitNum)
        customerNameLabel.text = customerName
        
        continueBtn.setTitle("Continue", for: .normal)
        continueBtn.backgroundColor = .blue
        continueBtn.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func continueBtnTapped() {}
    
    @IBAction func closeBtnTapped() {
        dismiss(animated: true, completion: nil)
    }

}
