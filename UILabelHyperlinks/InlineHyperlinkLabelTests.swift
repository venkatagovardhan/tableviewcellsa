//
//  InlineHyperlinkLabelTests.swift
//  UILabelHyperlinksTests
//
//  Created by Mahesh Dhumpeti on 21/06/22.
//

import XCTest
@testable import UILabelHyperlinks

class InlineHyperlinkLabelTests: XCTestCase {
    
    var hyperlinkLabel: InlineHyperlinkLabel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let attrString = NSMutableAttributedString(string: "abcdefghijklmnop")
        hyperlinkLabel = InlineHyperlinkLabel.build(with: attrString, alignment: .left, tapHandler: didTap)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetGetAttrString() {
        let attrString = NSMutableAttributedString(string: "abcdefghijklmnop")
        attrString.addHyperLinksAttribute(for: [("xyz", "abc")], font: UIFont.systemFont(ofSize: 17), color: UIColor.blue)
        hyperlinkLabel.attributedText = attrString
        XCTAssertNotNil(hyperlinkLabel.attributedText)
        XCTAssertNotNil(hyperlinkLabel.didTapOnLink)
    }
    
    func didTap(_ link: String) {}

    
}
