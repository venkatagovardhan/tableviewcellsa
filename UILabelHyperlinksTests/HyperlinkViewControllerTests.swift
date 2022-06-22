//
//  HyperlinkViewControllerTests.swift
//  UILabelHyperlinksTests
//
//  Created by Mahesh Dhumpeti on 21/06/22.
//

import XCTest
@testable import UILabelHyperlinks

class HyperlinkViewControllerTests: XCTestCase {
    
    var hyperlinkViewController: HyperlinkViewController!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        hyperlinkViewController = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "HyperlinkViewController") as? HyperlinkViewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewDidLoad() {
        hyperlinkViewController.loadViewIfNeeded()
        XCTAssertTrue(hyperlinkViewController.isViewLoaded)
    }
}
