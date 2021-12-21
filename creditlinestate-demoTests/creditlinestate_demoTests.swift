//
//  creditlinestate_demoTests.swift
//  creditlinestate-demoTests
//
//  Created by Mahesh Dhumpeti on 08/12/21.
//

import XCTest
@testable import creditlinestate_demo

class creditlinestate_demoTests: XCTestCase {
    
    let viewModel = CreditLineStatusViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCreditLineStatusCounterOffer() {
        viewModel.creditLineStatus = .counterOffer(amount: "10000") // NEW UPDATE
        
        XCTAssertNotNil(viewModel.getTopContainerBGColor())
//        XCTAssertNotNil(viewModel.getStatusImage())
        XCTAssertNotNil(viewModel.getStatusLabelText())
        XCTAssertNotNil(viewModel.getCaptionText())
        XCTAssertNotNil(viewModel.getInfoText())
        XCTAssertFalse(viewModel.isCancelHidden())
        XCTAssertEqual(viewModel.acceptBtnTitle(), "Accept")
    }
    
    func testCreditLineStatusApproved() {
        viewModel.creditLineStatus = .approved(amount: "10000") // NEW UPDATE
        
        XCTAssertNotNil(viewModel.getTopContainerBGColor())
//        XCTAssertNotNil(viewModel.getStatusImage())
        XCTAssertNotNil(viewModel.getStatusLabelText())
        XCTAssertNotNil(viewModel.getCaptionText())
        XCTAssertNotNil(viewModel.getInfoText())
        XCTAssertTrue(viewModel.isCancelHidden())
        XCTAssertEqual(viewModel.acceptBtnTitle(), "Return to account settings")
    }
    
    func testCreditLineStatusApplied() {
        viewModel.creditLineStatus = .applied(amount: "10000") // NEW UPDATE
        
        XCTAssertNotNil(viewModel.getTopContainerBGColor())
//        XCTAssertNotNil(viewModel.getStatusImage())
        XCTAssertNotNil(viewModel.getStatusLabelText())
        XCTAssertNotNil(viewModel.getCaptionText())
        XCTAssertNotNil(viewModel.getInfoText())
        XCTAssertTrue(viewModel.isCancelHidden())
        XCTAssertEqual(viewModel.acceptBtnTitle(), "Return to account settings")
    }
    
    func testCreditLineStatusPending() {
        viewModel.creditLineStatus = .pending(refNum: "12345") // NEW UPDATE
        
        XCTAssertNotNil(viewModel.getTopContainerBGColor())
//        XCTAssertNotNil(viewModel.getStatusImage())
        XCTAssertNotNil(viewModel.getStatusLabelText())
        XCTAssertNotNil(viewModel.getCaptionText())
        XCTAssertNotNil(viewModel.getInfoText())
        XCTAssertTrue(viewModel.isCancelHidden())
        XCTAssertEqual(viewModel.acceptBtnTitle(), "Return to account settings")
    }
    
    func testCreditLineStatusDeclined() {
        viewModel.creditLineStatus = .declined(amount: "10000") // NEW UPDATE
        
        XCTAssertNotNil(viewModel.getTopContainerBGColor())
//        XCTAssertNotNil(viewModel.getStatusImage())
        XCTAssertNotNil(viewModel.getStatusLabelText())
        XCTAssertNotNil(viewModel.getCaptionText())
        XCTAssertNotNil(viewModel.getInfoText())
        XCTAssertTrue(viewModel.isCancelHidden())
        XCTAssertEqual(viewModel.acceptBtnTitle(), "Return to account settings")
    }

}
