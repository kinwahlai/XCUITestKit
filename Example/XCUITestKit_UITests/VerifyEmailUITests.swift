//
//  VerifyEmailUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import XCUITestLiveReset

class VerifyEmailUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
//        app.launch()
        LiveResetClient.with {
            $0.app = app
            $0.delegate = self
            $0.launchEnvironment["custom"] = "value"
        }.resetOrLaunch()
    }

    override func tearDownWithError() throws {
    }

    func testYouAreAppEntryScreen() throws {
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["XCUITestKit Example"].staticTexts["XCUITestKit Example"].exists)
    }

    func testEmailYouEnteredIsValid() throws {
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["XCUITestKit Example"].staticTexts["XCUITestKit Example"].exists)
        app.tables.staticTexts["btn_testUIControls"].tap()
        XCTAssertEqual(app.staticTexts["headline_label"].title, "")

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].typeText("valid@email.com")
        let verifyEmailButton = app.buttons["verifyEmailButton"].staticTexts["verify email"]
        verifyEmailButton.tap()

        XCTAssertFalse(app.staticTexts["emailFieldError"].exists)
    }

    func testErrorMessageShownOnInvalidEmail() throws {
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["XCUITestKit Example"].staticTexts["XCUITestKit Example"].exists)
        app.tables.staticTexts["btn_testUIControls"].tap()
        XCTAssertEqual(app.staticTexts["headline_label"].title, "")

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].typeText("invalid-email.com")
        let verifyEmailButton = app.buttons["verifyEmailButton"].staticTexts["verify email"]
        verifyEmailButton.tap()

        XCTAssertTrue(app.staticTexts["emailFieldError"].exists)
        XCTAssertTrue(app.staticTexts["Please enter a valid email"].exists)
    }

    func testErrorMessageHiddenOnReplacedWithValidEmail() throws {
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["XCUITestKit Example"].staticTexts["XCUITestKit Example"].exists)
        app.tables.staticTexts["btn_testUIControls"].tap()
        XCTAssertEqual(app.staticTexts["headline_label"].title, "")

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].typeText("invalid-email.com")
        let verifyEmailButton = app.buttons["verifyEmailButton"].staticTexts["verify email"]
        verifyEmailButton.tap()

        XCTAssertTrue(app.staticTexts["emailFieldError"].exists)
        XCTAssertTrue(app.staticTexts["Please enter a valid email"].exists)

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].clearText()
        app.textFields["email_textfield"].typeText("valid@email.com")
        verifyEmailButton.tap()

        XCTAssertFalse(app.staticTexts["emailFieldError"].exists)
    }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = value as? String else {
            return
        }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}

extension XCTest: LiveResetClientDelegate {
    public func clientShutdown(withFatalError error: Error) {
        print("Fatal error - \(error.localizedDescription)")
        XCTFail(error.localizedDescription)
        XCUIApplication().terminate()
    }

    public func clientOperationFailed(withError error: Error) {
        print("Operation error \(error.localizedDescription)")
    }
}
