//
//  HyperlinkViewController.swift
//  UILabelHyperlinks
//
//  Created by Mahesh Dhumpeti on 21/06/22.
//

import UIKit

class HyperlinkViewController: UIViewController {
    @IBOutlet weak var inLineHyperlinkLabel: InlineHyperlinkLabel!
    
//    @IBOutlet weak var inLineHyperLinkTextView: InlineHyperlinkTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inline hyperlink texview
        let replacements = [("learn_more", "Learn more")]
        let attrString = NSMutableAttributedString(string: "Have questions about these payment options? Learn more", attributes: [.font: UIFont.systemFont(ofSize: 17)])
        attrString.addHyperLinksAttribute(for: replacements, font: UIFont.systemFont(ofSize: 17), color: .blue , underline: true)
        inLineHyperlinkLabel.isHidden = true
        inLineHyperlinkLabel.attributedText = attrString
        inLineHyperlinkLabel.didTapOnLink = didTap
        inLineHyperlinkLabel.textAlignment = .center
        
    }
    
    private func didTap(_ link: String) {
        let stepperVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "stepperVC")
        self.navigationController?.pushViewController(stepperVC, animated: true)
    }
}
