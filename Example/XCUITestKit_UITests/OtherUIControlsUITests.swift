//
//  OtherUIControlsUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import XCUITestLiveReset

class OtherUIControlsUITests: TestBaseWithLiveReset {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {}

    func testDelayedLabelShowsAfterFewseconds() throws {
        let app = XCUIApplication()
        app.tables.staticTexts["btn_testUIControls"].tap()
        sleep(4)
        XCTAssertTrue(app.staticTexts["delayedLabel"].exists)
    }

    func testSwitchOffTheToggle() throws {
        let app = XCUIApplication()
        app.tables.staticTexts["btn_testUIControls"].tap()

        XCTAssertTrue(app.switches["switch_control"].isHittable)
        app.switches["switch_control"].tap()
        XCTAssertEqual(app.switches["switch_control"].value as? String, "0")
    }

    func testAdjustPickerToCupertino() throws {
        let app = XCUIApplication()
        app.tables.staticTexts["btn_testUIControls"].tap()

        XCTAssertTrue(app.pickers["city_picker"].isHittable)
        app.pickers["city_picker"].pickerWheels.element.adjust(toPickerWheelValue: "Cupertino")
        XCTAssertEqual(app.pickers["city_picker"].pickerWheels.element.value as? String, "Cupertino")
        sleep(1)
        app.pickers["city_picker"].pickerWheels.element.adjust(toPickerWheelValue: "Bend")
        XCTAssertEqual(app.pickers["city_picker"].pickerWheels.element.value as? String, "Bend")
    }

    func testDismissAlertController() throws {
        let app = XCUIApplication()
        app.tables.staticTexts["btn_testUIControls"].tap()

        app.buttons["showAlert_button"].tap()

        XCTAssertTrue(app.alerts.staticTexts["Alert"].isHittable)

        XCTAssertEqual(app.alerts.staticTexts["Alert"].label, "Alert")
        XCTAssertEqual(app.alerts.staticTexts["show this for testing"].label, "show this for testing")

        app.alerts.buttons["Dismiss"].tap()
    }
}
