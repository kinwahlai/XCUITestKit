//
//  XCUITestKit_UITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/7/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest

class XCUITestKit_UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
}
