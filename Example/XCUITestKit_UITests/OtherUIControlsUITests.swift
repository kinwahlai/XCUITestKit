//
//  OtherUIControlsUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import XCUITestLiveReset

class OtherUIControlsUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        LiveResetClient.with {
            $0.app = app
            $0.delegate = self
            $0.launchEnvironment["example"] = "value"
        }.resetOrLaunch()
    }

    override func tearDownWithError() throws {
    }

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

        let elementsQuery = app.alerts["Alert"].scrollViews.otherElements
        XCTAssertTrue(elementsQuery.staticTexts["Alert"].isHittable)

        XCTAssertEqual(app.alerts.staticTexts["Alert"].label, "Alert")
        XCTAssertEqual(app.alerts.staticTexts["show this for testing"].label, "show this for testing")

        elementsQuery.buttons["Dismiss"].tap()
    }
}
