import UIKit

public final class InlineHyperlinkLabel: UILabel {
    
    // MARK: Creating the Label
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        numberOfLines = 0
        isUserInteractionEnabled = true
    }
        
    public override var attributedText: NSAttributedString? {
        get {
            return super.attributedText
        }
        set {
            super.attributedText = {
                guard let newValue = newValue else { return nil }
                // Apply custom hyperlink attributes
                let text = NSMutableAttributedString(attributedString: newValue)
                text.enumerateAttribute(.hyperlink, in: NSRange(location: 0, length: text.length), options: .longestEffectiveRangeNotRequired) { (value, subrange, _) in
                    text.addAttribute(.hyperlink, value: value as Any, range: subrange)
                }
                // Fill in font attributes when not set
                text.enumerateAttribute(.font, in: NSRange(location: 0, length: text.length), options: .longestEffectiveRangeNotRequired) { (value, subrange, _) in
                    guard value == nil, let font = font else { return }
                    text.addAttribute(.font, value: font, range: subrange)
                }
                return text
            }()
        }
    }
    
    // MARK: Finding Hyperlink Under Touch
    
    public var didTapOnLink: ((String) -> Void)?
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let string = self.string(at: touches) {
            didTapOnLink?(string)
        } else {
            super.touchesEnded(touches, with: event)
        }
    }
    
    private func string(at touches: Set<UITouch>) -> String? {
        guard let touchLocation = touches.sorted(by: { $0.timestamp < $1.timestamp } ).last?.location(in: self) else { return nil }
        guard let textStorage = preparedTextStorage() else { return nil }

        // Custom link style
        return touchLocation.evaluate(textStorage)
    }
    
    func preparedTextStorage() -> NSTextStorage? {
        guard let attributedText = attributedText, attributedText.length > 0 else { return nil }
        
        // Creates and configures a text storage which matches with the UILabel's configuration.
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0
        let textStorage = NSTextStorage(string: "")
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineBreakMode = lineBreakMode
        textContainer.size = textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines).size
        textStorage.setAttributedString(attributedText)
        
        return textStorage
    }
}

extension InlineHyperlinkLabel {
    
    public static func build(with attrString: NSMutableAttributedString,
                             alignment: NSTextAlignment,
                             tapHandler: @escaping (String) -> Void) -> InlineHyperlinkLabel {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        attrString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        
        let label = InlineHyperlinkLabel()
        label.attributedText = attrString
        label.translatesAutoresizingMaskIntoConstraints = false
        label.didTapOnLink = tapHandler
        return label
    }
    
}


extension NSAttributedString.Key {
    public static let hyperlink = NSAttributedString.Key("hyperlink")
}

extension NSMutableAttributedString {
        
    public typealias HyperLinkText = (link: String, text: String)

    public func addHyperLinksAttribute(for strings: [HyperLinkText], font: UIFont, color: UIColor, underline: Bool = false) {
        strings.forEach {
            addAttributes([.hyperlink: $0.link, .font: font, .foregroundColor: color, .underlineStyle: underline ? NSUnderlineStyle.single.rawValue : 0], range: (string as NSString).range(of: $0.text))
        }
    }
    
}

extension CGPoint {
    
    func evaluate(_ textStorage: NSTextStorage?) -> String? {
        guard let textStorage = textStorage else { return nil }

        let layoutManager = textStorage.layoutManagers[0]
        let textContainer = layoutManager.textContainers[0]
        
        let characterIndex = layoutManager.characterIndex(for: self, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        guard characterIndex >= 0, characterIndex != NSNotFound else { return nil }

        // Glyph index is the closest to the touch, therefore also validate if we actually tapped on the glyph rect
        let glyphRange = layoutManager.glyphRange(forCharacterRange: NSRange(location: characterIndex, length: 1), actualCharacterRange: nil)
        let characterRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        guard characterRect.contains(self) else { return nil }

        // Custom link style
        return textStorage.attribute(.hyperlink, at: characterIndex, effectiveRange: nil) as? String
    }
    
}
