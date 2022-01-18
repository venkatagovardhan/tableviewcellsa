//
//  CustomDialogView.swift
//  custom-alertview
//
//  Created by Mahesh Dhumpeti on 17/01/22.
//

import UIKit

class CustomDialogView: UIView {
        
    var onCloseTapCallback: (() -> Void)?
    var onActionTapCallback: (() -> Void)?

    @IBOutlet weak private var parentView: UIView!
    @IBOutlet weak private var alertView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var actionButton: UIButton!
    
    private var title: String?
    private var message: String?
    private var actionTitle: String?
    
    convenience init(title: String, message: String, actionTitle: String) {
        self.init(frame: UIScreen.main.bounds)
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        let bundle = Bundle(for: Self.self)
        bundle.loadNibNamed("CustomDialogView", owner: self, options: nil)
        
        alertView.layer.cornerRadius = 8
        
        parentView.frame = UIScreen.main.bounds
        parentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        actionButton.backgroundColor = .blue
        actionButton.layer.masksToBounds = true
        actionButton.layer.cornerRadius = 16
        actionButton.setTitleColor(.white, for: .normal)
    }

    @IBAction func actionButtonTapped(_ sender: Any) {
        dismiss()
        if let callback = self.onActionTapCallback {
            callback()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss()
        if let callback = self.onCloseTapCallback {
            callback()
        }
    }
    
    func show() {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        titleLabel.text = title
        messageLabel.text = message
        actionButton.setTitle(actionTitle, for: .normal)
        keyWindow.addSubview(parentView)
    }
    
    func dismiss() {
        parentView.removeFromSuperview()
    }
    
}
