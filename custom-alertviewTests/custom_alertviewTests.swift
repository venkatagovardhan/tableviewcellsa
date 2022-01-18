//
//  custom_alertviewTests.swift
//  custom-alertviewTests
//
//  Created by Mahesh Dhumpeti on 17/01/22.
//

import XCTest
@testable import custom_alertview

class custom_alertviewTests: XCTestCase {
    
    var dialog: CustomDialog?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dialog = CustomDialog(title: "abc", message: "123", actionTitle: "456")
        dialog?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDialogLoaded() {
        XCTAssertNotNil(dialog)
    }
    
    func testActionTap() {
        dialog?.actionButtonTapped()
    }

    func testCloseTap() {
        dialog?.closeButtonTapped()
    }
}
