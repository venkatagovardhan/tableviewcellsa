import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    private lazy var resultLabel: UILabel = .sectionTitle("Tap on the label…")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.addArrangedSubview(resultLabel)
        
        stackView.addArrangedSubview(UILabel.sectionTitle("Left alignment"))
        
        let replacements = [("augmented_code", "Augmented Code"),
                            ("signal_path", "SignalPath"),
                            ("https://www.github.com", "GitHub")]
        let attrString = NSMutableAttributedString(string: "Check this webpage: Augmented Code. Link to SignalPath on the App Store. Finally link to GitHub. This will make the string with underlined style, also you can replace the .underlinestyle and use .link to show it as a hyperlink in blue color. This will make the string with underlined style, also you can replace the .underlinestyle and use .link to show it as a hyperlink in blue color. This will make the string with underlined style, also you can replace the .underlinestyle and use .link to show it as a hyperlink in blue color. This will make the string with underlined style, also you can replace the .underlinestyle and use .link to show it as a hyperlink in blue color")
        attrString.addHyperLinksAttribute(for: replacements, font: .boldSystemFont(ofSize: 10), color: .blue, underline: true)
        attrString.addHyperLinksAttribute(for: [("signal_path", "SignalPath")], font: .boldSystemFont(ofSize: 22), color: .red)
        attrString.addHyperLinksAttribute(for: [("https://www.github.com", "GitHub")], font: .systemFont(ofSize: 16), color: .gray)
        stackView.addArrangedSubview(InlineHyperlinkLabel.build(with: attrString, alignment: .left, tapHandler: didTap))
    }
    
    private func didTap(_ link: String) {
        if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            resultLabel.text = "Did tap on: \(link)"
        }
    }
}

private extension UILabel {
    static func sectionTitle(_ title: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
