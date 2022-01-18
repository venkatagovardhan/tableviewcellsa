//
//  CustomDialog.swift
//  custom-alertview
//
//  Created by Mahesh Dhumpeti on 17/01/22.
//

import UIKit

class CustomDialog: UIViewController {

    var onClose: (() -> Void)?
    var onAction: (() -> Void)?

    @IBOutlet weak private var alertView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var actionBtnBackView: UIView!
    @IBOutlet weak private var actionButton: UIButton!
    
    private var dialogTitle: String?
    private var dialogMessage: String?
    private var actionTitle: String?
    
    convenience init(title: String, message: String, actionTitle: String) {
        self.init(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
        self.dialogTitle = title
        self.dialogMessage = message
        self.actionTitle = actionTitle
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        alertView.layer.cornerRadius = 8
                
        actionBtnBackView.backgroundColor = .blue
        actionBtnBackView.layer.cornerRadius = 16
        actionButton.setTitleColor(.white, for: .normal)
        
        titleLabel.text = dialogTitle
        titleLabel.textColor = .blue
        
        messageLabel.text = dialogMessage
        actionButton.setTitle(actionTitle, for: .normal)
    }
    
    @IBAction func actionButtonTapped() {
        dismiss()
        if let callback = self.onAction {
            callback()
        }
    }
    
    @IBAction func closeButtonTapped() {
        dismiss()
        if let callback = self.onClose {
            callback()
        }
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }

}
