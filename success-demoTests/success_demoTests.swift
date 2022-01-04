//
//  success_demoTests.swift
//  success-demoTests
//
//  Created by Mahesh Dhumpeti on 04/01/22.
//

import XCTest
@testable import success_demo

class success_demoTests: XCTestCase {

    var viewModel: SuccessViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = SuccessViewModel()
        viewModel.cards = mockData
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testCardsData() {
        XCTAssertEqual(viewModel.cards.count, mockData.count)
    }

    func testNumberOfRows() {
        XCTAssertEqual(viewModel.cards.count, viewModel.numberOfRows())
    }
    
    func testEnabledCorners() {
        XCTAssertGreaterThan(viewModel.numberOfRows(), 0)
        XCTAssertEqual(viewModel.getCorners(for: 0), [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        XCTAssertEqual(viewModel.getCorners(for: viewModel.numberOfRows() - 1), [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
    }
    
    func testGetCard() {
        let ip = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(viewModel.getCard(for: ip))
        
        viewModel.cards = []
        XCTAssertNil(viewModel.getCard(for: ip))
    }

}
