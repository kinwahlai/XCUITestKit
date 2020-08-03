//
//  RemoteConfigUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/31/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import XCUITestLiveReset

class RemoteConfigUITests: TestBaseWithLiveReset {
    override func setUpWithError() throws {
        try super.setUpWithError()

        let settings: ServiceSettings = ["mock_server_port": .intValue(1234), "persist": .boolValue(false), "test_case": .stringValue("\(name)")]
        LiveResetClient.shared.configure(settings: settings)
    }

    override func tearDownWithError() throws {}

    func testShowSettingsSentInSetup() throws {
        let expected = """
ServiceSettings:
===================
mock_server_port: 1234
persist: false
test_case: -[RemoteConfigUITests testShowSettingsSentInSetup]
===================
"""
        let app = XCUIApplication()
        assertHeaderText()
        app.tables.staticTexts["btn_testUIControls"].tap()
        app.navigationBars["UI Controls"].buttons["More"].tap()

        XCTAssertEqual(app.textViews["configView"].value as! String, expected)
    }

//    func testNewSettingsAppendToCurrent() throws {
//
//        LiveResetClient.shared.configure(settings: ["some_key": .intValue(778877)])
//
//        let expected = """
//ServiceSettings:
//===================
//mock_server_port: 1234
//persist: false
//some_key: 778877
//test_case: -[RemoteConfigUITests testExample]
//===================
//"""
//        let app = XCUIApplication()
//        assertHeaderText()
//        app.tables.staticTexts["btn_testUIControls"].tap()
//        app.navigationBars["UI Controls"].buttons["More"].tap()
//
//        XCTAssertEqual(app.textViews["configView"].value as! String, expected)
//    }
}
