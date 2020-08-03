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
    let defaultExpected = """
ServiceSettings:
===================
mock_server_port: 1234
persist: false
===================
"""
    override func setUpWithError() throws {
        try super.setUpWithError()

        let settings: ServiceSettings = ["mock_server_port": .intValue(1234), "persist": .boolValue(false)]
        LiveResetClient.shared.configure(settings: settings)
    }

    override func tearDownWithError() throws {}

    func testShowSettingsSentInSetup() throws {
        let app = XCUIApplication()
        assertHeaderText()
        app.tables.staticTexts["btn_testUIControls"].tap()
        app.navigationBars["UI Controls"].buttons["More"].tap()
        XCTAssertTrue(app.staticTexts["remote config received:"].exists)
        XCTAssertEqual(app.staticTexts["configView"].label, defaultExpected)
    }

    func testNewSettingsAppendToCurrent() throws {
        LiveResetClient.shared.configure(settings: ["some_key": .intValue(778877), "test_case": .stringValue("\(name)")])

        let expected = """
ServiceSettings:
===================
mock_server_port: 1234
persist: false
some_key: 778877
test_case: -[RemoteConfigUITests testNewSettingsAppendToCurrent]
===================
"""
        let app = XCUIApplication()
        assertHeaderText()
        app.tables.staticTexts["btn_testUIControls"].tap()
        app.navigationBars["UI Controls"].buttons["More"].tap()
        XCTAssertTrue(app.staticTexts["remote config received:"].exists)
        XCTAssertEqual(app.staticTexts["configView"].label, expected)
    }

    func testUntilNextResetAdHocSettingAppendToCurrentSessionData() throws {
        let app = XCUIApplication()
        assertHeaderText()
        app.tables.staticTexts["btn_testUIControls"].tap()
        app.navigationBars["UI Controls"].buttons["More"].tap()
        XCTAssertTrue(app.staticTexts["remote config received:"].exists)
        XCTAssertEqual(app.staticTexts["configView"].label, defaultExpected)

        LiveResetClient.shared.configure(settings: ["AAA": .intValue(1)])
        XCTAssertTrue(app.staticTexts["configView"].label.contains("AAA: 1"))

        LiveResetClient.shared.configure(settings: ["BBB": .intValue(2)])
        XCTAssertTrue(app.staticTexts["configView"].label.contains("BBB: 2"))

        LiveResetClient.shared.configure(settings: ["CCC": .intValue(3)])
        XCTAssertTrue(app.staticTexts["configView"].label.contains("CCC: 3"))

        LiveResetClient.shared.configure(settings: ["DDD": .intValue(4)])
        XCTAssertTrue(app.staticTexts["configView"].label.contains("DDD: 4"))
    }
}
