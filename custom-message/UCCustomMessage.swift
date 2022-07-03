//
//  UCCustomMessage.swift
//  custom-message
//
//  Created by Mahesh Dhumpeti on 29/06/22.
//

import Foundation
import UIKit

public enum MessageType: String {
    case message
    case alert
    case alertWithLink
    case alertWithButton
}
public enum MessageStyle: String {
    case info
    case success
    case error
}

@IBDesignable public class UCCustomMessage: UIView {
    
    @IBOutlet public weak var contentView: UIView!
    @IBOutlet public weak var messageLabel: UILabel!
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var icon: UIImageView!
    @IBOutlet public weak var dismissButton: UIButton!
    @IBOutlet public weak var linkButton: UIButton!
    @IBOutlet weak var buttonPadding: NSLayoutConstraint!
    @IBOutlet weak var linkButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageLabelBottomConstraint: NSLayoutConstraint!
    
    //MARK: IBInspectables
    
    /// Attribute: ParentView background color.
    @IBInspectable
    public var viewBgColor: UIColor? = UIColor.gray {
        didSet {
            self.contentView.backgroundColor = viewBgColor
        }
    }
    /// Attribute: Custom text for MESSAGE component.
    @IBInspectable
    public var label: String = "" {
        didSet {
            self.messageLabel.text = label
        }
    }
    
    /// Attribute: Custom title text
    @IBInspectable
    public var titleText: String = "" {
        didSet {
            self.titleLabel.text = titleText
        }
    }
    ///Attribute: Custom text color for label.
    @IBInspectable
    public var textColor: UIColor? = UIColor.black {
        didSet {
            self.messageLabel.textColor = textColor
        }
    }
    
    /// Attribute: Customize label font
    @IBInspectable
    public var font: UIFont? = UIFont.systemFont(ofSize: 16) {
        didSet {
            self.messageLabel.font = font
        }
    }
    /// Attribute: Customize title font
    @IBInspectable
    public var titleFont: UIFont? = UIFont.systemFont(ofSize: 21) {
        didSet {
            self.titleLabel.font = titleFont
        }
    }
    
    /// Attribute: Customize title color
    @IBInspectable
    public var titleColor: UIColor? = UIColor.blue {
        didSet {
            self.titleLabel.textColor = titleColor
        }
    }
    
    /// Attribute: Change border color
    @IBInspectable
    public var borderColor: UIColor? = UIColor.brown {
        didSet {
            self.contentView.layer.borderColor = borderColor?.cgColor
        }
    }
    @IBInspectable
    public var borderWidth: CGFloat = 2 {
        didSet {
            self.contentView.layer.borderWidth = borderWidth
        }
    }
    
    /// Attribute: Change border radius
    @IBInspectable
    public var borderRadius: CGFloat = 8.0 {
        didSet {
            self.contentView.layer.cornerRadius = borderRadius
        }
    }
    
    /// Attribute: Link text
    @IBInspectable
    public var linkText: NSAttributedString? {
        didSet {
            self.linkButton.setAttributedTitle(linkText, for: .normal)
        }
    }
    /// Attribute: Button text
    @IBInspectable
    public var buttonText: NSAttributedString? {
        didSet {
            self.linkButton.setAttributedTitle(linkText, for: .normal)
        }
    }
    
    /// Attribute: Button color
    @IBInspectable
    public var buttonColor: UIColor? = UIColor.red {
        didSet {
            self.linkButton.layer.backgroundColor = buttonColor?.cgColor
        }
    }
    
    /// Attribute: Button Width
    public var buttonWidth: CGFloat = 100 {
        didSet {
            self.buttonWidthConstraint?.isActive = false
            self.buttonWidthConstraint = linkButton.widthAnchor.constraint(equalToConstant: buttonWidth)
            self.buttonWidthConstraint?.isActive = true
        }
    }
    /// Attribute: Button Height
    public var buttonHeight: CGFloat = 32 {
        didSet {
            self.buttonHeightConstraint?.isActive = false
            self.buttonHeightConstraint = linkButton.heightAnchor.constraint(equalToConstant: buttonHeight)
            self.buttonHeightConstraint?.isActive = true
        }
    }
    
    /// Attribute: Button text color
    @IBInspectable
    public var buttonTextColor: UIColor? = UIColor.white {
        didSet {
            self.linkButton.setTitleColor(buttonTextColor, for: .normal)
        }
    }
    /// Attribute: Center button in the middle of the view
    @IBInspectable
    public var centerButton: Bool = false {
        didSet {
            if centerButton {
                buttonPadding.constant = (contentView.bounds.width / 2) - (linkButton.bounds.width / 2)
            } else {
                buttonPadding.constant = 16
            }
        }
    }
    
    /// Attribute: display title in alert
    @IBInspectable
    public var displayTitle: Bool = true {
        didSet {
            if displayTitle {
                messageTopViewConstraint?.isActive = false
                titleLabel.isHidden = false
            }
            else {
                messageTopViewConstraint?.isActive = true
                titleLabel.isHidden = true
            }
        }
    }
    /// Attribute: Adjust style to be error, info, or success
    public var messageStyle: MessageStyle = .info {
        didSet {
            self.setMessageStyle(messageStyle)
        }
    }
    /// Attribute: Adjust style to contain close button, alert, alert with button, alert with link
    public var messageType: MessageType = .message {
        didSet {
            self.setupEntryType(messageType)
        }
    }
    
    /// Action: Used for action after clicking on link or button
    public var linkAction: (() -> Void)?
    
    /// Action: Used for after clicking on the dismiss button
    public var dismissAction: (() -> Void)?
    
    /// Helper: Contraints to edit the height and width of the button
    private var buttonWidthConstraint: NSLayoutConstraint?
    private var buttonHeightConstraint: NSLayoutConstraint?
    /// Helper: used to set the constraint from the top of the message
    private var messageTopViewConstraint: NSLayoutConstraint?
    
    //MARK: Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadNib()
    }
    
    /// INIT: Set the title, label and message type from the init function
    public init(_ frame: CGRect, labelText: String? = nil, titleText: String? = "", type: MessageType = .message) {
        super.init(frame: frame)
        self.loadNib()
        self.setUpUI(labelText: labelText, titleText: titleText, type: type)
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setUpUI()
    }
    
    func loadNib() {
        self.instantiateViewFromNib()
        self.contentView.frame = self.bounds
        self.addSubview(self.contentView)
        self.messageTopViewConstraint = messageLabel.topAnchor.constraint(greaterThanOrEqualTo: icon.bottomAnchor, constant: 9)
        self.setupEntryType(self.messageType)
    }
    /// Method: This method is called when MESSAGE COMPONENT is initalized programmactically.
    public func setUpUI(labelText: String? = nil, titleText: String? = nil, type: MessageType = .message) {
        self.contentView.layer.cornerRadius = borderRadius
        self.contentView.layer.borderWidth = borderWidth
        self.contentView.layer.borderColor = borderColor?.cgColor
        self.contentView.backgroundColor = viewBgColor
        self.titleLabel.textColor = titleColor
        self.titleLabel.text = titleText ?? self.titleText
        self.messageLabel.text = labelText ?? self.label
        self.messageLabel.sizeToFit()
        self.messageLabel.textColor = textColor
        self.messageLabel.font = font
        self.messageType = type
        self.setupEntryType(type)
    }
    /// Helper: Used to switch between the Message Types
    public func setupEntryType(_ type: MessageType) {
        switch type {
        case MessageType.message:
            dismissButton.isHidden = true
            linkButton.isHidden = true
            
        case MessageType.alert:
            dismissButton.isHidden = false
            linkButton.isHidden = true
            
        case MessageType.alertWithLink:
            dismissButton.isHidden = false
            linkButton.isHidden = false
            
        case MessageType.alertWithButton:
            dismissButton.isHidden = false
            linkButton.isHidden = false
            setupLinkButton()
        }
        guard let messageLabelBottomConstraint = self.messageLabelBottomConstraint,
              let linkButtonTopConstraint =  self.linkButtonTopConstraint else {
            return
        }
        if linkButton.isHidden {
            ///Remove extra space from bottom
            
            messageLabelBottomConstraint.constant = 10
            messageLabelBottomConstraint.isActive = true
            
            linkButtonTopConstraint.constant = 0
            linkButtonTopConstraint.isActive = false
        } else {
            messageLabelBottomConstraint.constant = 0
            messageLabelBottomConstraint.isActive = false
            linkButtonTopConstraint.constant = 15
            linkButtonTopConstraint.isActive = true
        }
    }
    /// Helper: Used to setup the link button
    private func setupLinkButton() {
        self.linkButton.layer.cornerRadius = 16.0
        self.linkButton.setAttributedTitle(self.buttonText, for: .normal)
        self.linkButton.layer.backgroundColor = self.buttonColor?.cgColor
        self.linkButton.setTitleColor(self.buttonTextColor, for: .normal)
        self.linkButton.contentHorizontalAlignment = .center
    }
    /// Helper: Changes between the three message types
    public func setMessageStyle(_ style: MessageStyle) {
        switch style {
        case .error:
            setErrorStyle()
        case .info:
            setInfoStyle()
        case .success:
            setSuccessStyle()
        }
    }
    /// Helper: Displays the success green style
    private func setSuccessStyle() {
        self.icon.image = UIImage(named: "checkmark", in: Bundle.main.self, compatibleWith: nil)
        self.viewBgColor = UIColor.green
        self.borderColor = UIColor.brown
        self.titleColor = UIColor.lightGray
    }
    /// Helper: Displays the information blue style
    private func setInfoStyle() {
        self.icon.image = UIImage(named: "information-icon", in:Bundle.main.self, compatibleWith: nil)
        self.contentView.backgroundColor = viewBgColor
        self.contentView.layer.borderColor = borderColor?.cgColor
        self.titleLabel.textColor = titleColor
    }
    /// Helper: Displays the error red style
    private func setErrorStyle() {
        self.icon.image = UIImage(named: "error-icon", in: Bundle.main.self, compatibleWith: nil)
        self.viewBgColor = UIColor.red
        self.borderColor = UIColor.red
        self.titleColor = UIColor.red
    }
    /// Helper: When dismiss action closure is called alert type
    @IBAction func dismissAction(_ sender: Any) {
        guard let action = dismissAction else {
            return
        }
        action()
    }
    /// Helper: When link action closure is called in alert type
    @IBAction func linkAction(_ sender: Any) {
        guard let action = linkAction else {
            return
        }
        action()
    }
}
extension UCCustomMessage: NibLoadable {
    public func instantiateViewFromNib() {
        self.contentView = self.loadFromNib()
    }
}

// MARK: Protocol Definition
/// Make your UIView subclasses conform to this protocol when:
///  * they *are* NIB-based, and
///  * this class is used as the XIB's root view
///
/// to be able to instantiate them from the NIB in a type-safe manner
public protocol NibLoadable: AnyObject {
    /// The nib file to use to load a new instance of the View designed in a XIB
    var nib: UINib { get }
}

// MARK: Default implementation
public extension NibLoadable {
    /// By default, use the nib which have the same name as the name of the class,
    /// and located in the bundle of that class
    var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: Bundle(for: Self.self))
    }
}

// MARK: Support for instantiation from NIB
public extension NibLoadable where Self: UIView {
    /**
     Returns a `UIView` object instantiated from nib
     - returns: A `NibLoadable`, `UIView` instance
     */
    func loadFromNib() -> Self {
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? Self else {
            fatalError("The nib \(nib) expected its root view to be of type \(self)")
        }
        return view
    }
}

