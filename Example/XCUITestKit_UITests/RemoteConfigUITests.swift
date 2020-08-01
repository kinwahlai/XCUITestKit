//
//  RemoteConfigUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/31/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import XCUITestLiveReset

class RemoteConfigUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        LiveResetClient.with {
            $0.app = app
            $0.delegate = self
        }.resetOrLaunch()
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["XCUITestKit Example"].staticTexts["XCUITestKit Example"].exists)
        app.tables.staticTexts["btn_testUIControls"].tap()
        app.navigationBars["UI Controls"].buttons["More"].tap()

        XCTAssertEqual(app.textViews["configView"].value as! String, "aaa")
    }

}
