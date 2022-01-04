//
//  CardCell.swift
//  success-demo
//
//  Created by Mahesh Dhumpeti on 04/01/22.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var cardContainerView: UIView!
    
    @IBOutlet weak var cardNumLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    
    @IBOutlet weak var primaryLabelView: UIView!
    @IBOutlet weak var primaryLabel: UILabel!
    
    static var cellId: String {
        return String(describing: self)
    }
    
    var card: CardVO? {
        didSet {
            configureCell()
        }
    }
    
    var enabledCorners: CACornerMask = []
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configureCell() {
        guard let card = card else { return }
        selectionStyle = .none
        
        cardContainerView.layer.cornerRadius = 8.0
        cardContainerView.layer.maskedCorners = enabledCorners
        cardContainerView.layer.borderWidth = 0.5
        cardContainerView.layer.borderColor = UIColor.gray.cgColor
        
        cardNumLabel.text = String(format: "%@...%@", card.fullCardName, card.last4DigitsOfAcctNo)
        customerNameLabel.text = card.nameOnCard
        
        primaryLabelView.backgroundColor = .green
        primaryLabel.textColor = .white
        primaryLabel.text = "Primary"
    }

}
