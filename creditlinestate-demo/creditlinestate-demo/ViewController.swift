//
//  ViewController.swift
//  creditlinestate-demo
//
//  Created by Mahesh Dhumpeti on 04/12/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var topStateImageView: UIImageView!
    @IBOutlet weak var topStatusLabel: UILabel!
    
    @IBOutlet weak var amountCaptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var phoneNumBtn: UIButton!

    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    let viewModel = CreditLineStateViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.currentState = .counterOffer
        setupUI()
    }
    
    private func setupUI() {
        topContainerView.backgroundColor = viewModel.getContainerBGColor()
        topStateImageView.image = viewModel.getStatusImage()
        topStatusLabel.text = viewModel.getStatusLabelText()
        amountCaptionLabel.text = viewModel.getCaptionText()
        amountLabel.text = "$5,000.00" // Add amount/reference number dynalically
        infoLabel.attributedText = viewModel.getInfoText()
        
        let blue = UIColor.blue
        acceptBtn.backgroundColor = blue
        acceptBtn.setTitle(viewModel.acceptBtnTitle(), for: .normal)
        acceptBtn.setTitleColor(.white, for: .normal)
        acceptBtn.layer.cornerRadius = 24
        
        cancelBtn.backgroundColor = .clear
        cancelBtn.setTitle("Cancel", for: .normal)
        cancelBtn.setTitleColor(blue, for: .normal)
        cancelBtn.layer.cornerRadius = 24
        cancelBtn.layer.borderColor = blue.cgColor
        cancelBtn.layer.borderWidth = 1
        cancelBtn.isHidden = viewModel.isCancelHidden()
        
        phoneNumBtn.setTitle("9876543210", for: .normal) // Add phone number dynalically
    }
    
    @IBAction func phoneNumBtnTapped() {
        if let num = phoneNumBtn.currentTitle,
           let url = URL(string: num),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func closeBtnTapped() {
        
    }

    @IBAction func acceptBtnTapped() {
        
    }
    
    @IBAction func cancelBtnTapped() {
        
    }

}

