//
//  CreditLineStatusViewModel.swift
//  creditlinestate-demo
//
//  Created by Mahesh Dhumpeti on 04/12/21.
//

import UIKit

extension String {
    
    var image: UIImage? {
        return UIImage(named: self)?.withRenderingMode(.alwaysOriginal)
    }
    
    // NEW UPDATE
    func getCreditLineStatus(associatedValue value: String? = nil) -> CreditLineStatus? {
        switch self {
        case "counter_offer": return nil
        case "approved": return nil
        case "applied": return nil
        case "pending": return .pending(refNum: value)
        case "declined": return nil
        default: return nil
        }
    }
}

extension NSMutableAttributedString {
    
    func appendText(_ string: String, font: UIFont, color: UIColor) {
        let newString = NSAttributedString(string: string,
                                           attributes: [.font: font, .foregroundColor: color])
        append(newString)
    }
    
    func appendHyperLinkText(_ string: String, font: UIFont, color: UIColor, link: String) {
        let newString = NSAttributedString(string: string,
                                           attributes: [.font: font, .foregroundColor: color, .link: link])
        append(newString)
    }
    
}

extension UIColor {
    
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
}

extension UIFont {
    
    static var normal: UIFont {
        UIFont.systemFont(ofSize: 17)
    }
    
    static var bold: UIFont {
        UIFont.boldSystemFont(ofSize: 17)
    }
    
}

// NEW UPDATE
enum CreditLineStatus {
    case counterOffer
    case approved
    case applied
    case pending(refNum: String?)
    case declined
        
    var statusImage: UIImage? {
        switch self {
        case .counterOffer:
            return "".image
        case .approved:
            return "".image
        case .applied:
            return "".image
        case .pending:
            return "".image
        case .declined:
            return "".image
        }
    }
    
    var statusText: String? {
        switch self {
        case .counterOffer:
            return "Your Credit line increase request has been approved!"
        case .approved:
            return "Congratulations Samantha!"
        case .applied:
            return "Your have already requested a credit line increase!"
        case .pending:
            return "Your Credit line increase request is pending!"
        case .declined:
            return "Your Credit line increase request has been declined!"
        }
    }
    
    var captionText: String? {
        switch self {
        case .counterOffer:
            return "New credit line increase amount:"
        case .approved:
            return "New credit line increase amount:"
        case .applied:
            return "New credit line increase amount:"
        case .pending:
            return "Your reference number:"
        case .declined:
            return "Credit line increase amount requested:"
        }
    }
    
    var infoText: NSAttributedString? {
        let attrString = NSMutableAttributedString(string: "")
        switch self {
        case .counterOffer:
            attrString.appendText("Swift's strings are great for storing plain text, but as soon as you want formatting, images, or interactivity you need to reach for NSAttributedString - Foundation’s all-in-one string handling class. These are used in various places in iOS and macOS, but you're most likely to want to use them with UILabel and UITextView, both of which accept attributed strings directly. In this article I'll walk you through examples of what NSAttributedString is capable of: creating strings by hand, adding and enumerating attributes, adding links and images, and more. All these code samples are written to work with a Swift playground, which is a particularly good place to try out attributed strings because Xcode can render a preview of how the string looks. Swift's strings are great for storing plain text, but as soon as you want formatting, images, or interactivity you need to reach for NSAttributedString - Foundation’s all-in-one string handling class. These are used in various places in iOS and macOS, but you're most likely to want to use them with UILabel and UITextView, both of which accept attributed strings directly. To accept this new credit line increase. \nPlease click or tap ", font: UIFont.normal, color: .black)
            attrString.appendText("'Accept'", font: UIFont.bold, color: .black)
            attrString.appendText("\n\n", font: UIFont.normal, color: .black)
            attrString.appendText("To decline please click on tap", font: UIFont.normal, color: .black)
            attrString.appendText("'Cancel'", font: UIFont.bold, color: .black)
            attrString.appendText(" ", font: UIFont.normal, color: .black)
            attrString.appendHyperLinkText("9000012345", font: UIFont.bold, color: UIColor.blue, link: "+919000012345")
            return attrString
        case .approved:
            attrString.appendText("To accept this new credit line increase. \nPlease click or tap ", font: UIFont.normal, color: .black)
            attrString.appendText("'Accept'", font: UIFont.bold, color: .black)
            attrString.appendText("\n\n", font: UIFont.normal, color: .black)
            attrString.appendText("To decline please click on tap", font: UIFont.normal, color: .black)
            attrString.appendText("'Cancel'", font: UIFont.bold, color: .black)
            return attrString
        case .applied:
            attrString.appendText("To accept this new credit line increase. \nPlease click or tap ", font: UIFont.normal, color: .black)
            attrString.appendText("'Accept'", font: UIFont.bold, color: .black)
            attrString.appendText("\n\n", font: UIFont.normal, color: .black)
            attrString.appendText("To decline please click on tap", font: UIFont.normal, color: .black)
            attrString.appendText("'Cancel'", font: UIFont.bold, color: .black)
            return attrString
        case .pending(let refNum): // NEW UPDATE
            if let num = refNum, num.count > 0 { attrString.appendText("Reference number: \(num). ", font: UIFont.normal, color: .black) } // NEW UPDATE
            attrString.appendText("To accept this new credit line increase. \nPlease click or tap ", font: UIFont.normal, color: .black)
            attrString.appendText("'Accept'", font: UIFont.bold, color: .black)
            attrString.appendText("\n\n", font: UIFont.normal, color: .black)
            attrString.appendText("To decline please click on tap", font: UIFont.normal, color: .black)
            attrString.appendText("'Cancel'", font: UIFont.bold, color: .black)
            return attrString
        case .declined:
            attrString.appendText("To accept this new credit line increase. \nPlease click or tap ", font: UIFont.normal, color: .black)
            return attrString
        }
    }
    
    var topContainerBGColor: UIColor {
        switch self {
        case .counterOffer:
            return UIColor.rgb(r: 255, g: 255, b: 255)
        case .approved:
            return UIColor.rgb(r: 255, g: 255, b: 255)
        case .applied:
            return UIColor.rgb(r: 255, g: 255, b: 255)
        case .pending:
            return UIColor.rgb(r: 255, g: 255, b: 255)
        case .declined:
            return UIColor.rgb(r: 255, g: 255, b: 255)
        }
    }
    
    // NEW UPDATE
    var isCancelHidden: Bool {
        switch self {
        case .counterOffer: return false
        case .approved, .applied, .pending, .declined: return true
        }
    }
    
    // NEW UPDATE
    var acceptBtnTitle: String {
        switch self {
        case .counterOffer: return "Accept"
        case .approved, .applied, .pending, .declined: return "Return to account settings"
        }
    }
    
}

class CreditLineStatusViewModel {
    
    var creditLineStatus: CreditLineStatus?
    
    // MARK: - Getters
    
    func getTopContainerBGColor() -> UIColor? {
        guard let state = creditLineStatus else { return nil }
        return state.topContainerBGColor
    }
    
    func getStatusImage() -> UIImage? {
        guard let state = creditLineStatus else { return nil }
        return state.statusImage
    }
    
    func getStatusLabelText() -> String? {
        guard let state = creditLineStatus else { return nil }
        return state.statusText
    }
    
    func getCaptionText() -> String? {
        guard let state = creditLineStatus else { return nil }
        return state.captionText
    }
    
    func getInfoText() -> NSAttributedString? {
        guard let state = creditLineStatus else { return nil }
        return state.infoText
    }
    
    func isCancelHidden() -> Bool {
        guard let state = creditLineStatus else { return true }
        return state.isCancelHidden
    }
    
    func acceptBtnTitle() -> String? {
        guard let state = creditLineStatus else { return nil }
        return state.acceptBtnTitle
    }
    
}

