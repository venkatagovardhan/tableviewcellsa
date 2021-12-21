//
//  CreditLineStatusViewController.swift
//  creditlinestate-demo
//
//  Created by Mahesh Dhumpeti on 04/12/21.
//

import UIKit

class CreditLineStatusViewController: UIViewController {
    
    @IBOutlet weak var topContainerView: UIView!
    @IBOutlet weak var topStateImageView: UIImageView!
    @IBOutlet weak var topStatusLabel: UILabel!
    
    @IBOutlet weak var amountCaptionLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var infoTextView: UITextView!

    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    let viewModel = CreditLineStatusViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // For suppose you received status from API as mentioned below
        
        let status = "pending"
        let refNum = "12345"
        
        // NEW UPDATE
        viewModel.creditLineStatus = status.getCreditLineStatus(associatedValue: refNum)
        setupUI()
    }
    
    private func setupUI() {
        topContainerView.backgroundColor = viewModel.getTopContainerBGColor()
        topStateImageView.image = viewModel.getStatusImage()
        topStatusLabel.text = viewModel.getStatusLabelText()
        amountCaptionLabel.text = viewModel.getCaptionText()
        amountLabel.text = "$5,000.00" // Add amount/reference number dynalically
        
        infoTextView.attributedText = viewModel.getInfoText()
        infoTextView.delegate = self
        infoTextView.isEditable = false
        infoTextView.isScrollEnabled = false
        infoTextView.sizeToFit()
        
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
    }
    
    @IBAction func closeBtnTapped() {
        
    }

    @IBAction func acceptBtnTapped() {
        
    }
    
    @IBAction func cancelBtnTapped() {
        
    }

}

extension CreditLineStatusViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if textView == infoTextView, UIApplication.shared.canOpenURL(URL) {
            UIApplication.shared.open(URL, options: [:], completionHandler: nil)
            return true
        }
        return false
    }
    
}

