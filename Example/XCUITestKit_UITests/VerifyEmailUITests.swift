//
//  VerifyEmailUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import XCUITestLiveReset

func assertHeaderText() {
    if #available(iOS 13.0, *) {
        XCTAssertTrue(XCUIApplication().staticTexts["XCUITestKit Example"].exists)
    } else {
        XCTAssertTrue(XCUIApplication().otherElements["XCUITestKit Example"].exists)
    }
}

class VerifyEmailUITests: TestBaseWithLiveReset {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {}

    func testYouAreAppEntryScreen() throws {
        assertHeaderText()
    }

    func testEmailYouEnteredIsValid() throws {
        let app = XCUIApplication()
        assertHeaderText()
        app.tables.staticTexts["btn_testUIControls"].tap()
        XCTAssertEqual(app.staticTexts["headline_label"].title, "")

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].typeText("valid@email.com")
        let verifyEmailButton = app.buttons["verifyEmailButton"]
        verifyEmailButton.tap()

        XCTAssertFalse(app.staticTexts["emailFieldError"].exists)
    }

    func testErrorMessageShownOnInvalidEmail() throws {
        let app = XCUIApplication()
        assertHeaderText()
        app.tables.staticTexts["btn_testUIControls"].tap()
        XCTAssertEqual(app.staticTexts["headline_label"].title, "")

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].typeText("invalid-email.com")
        let verifyEmailButton = app.buttons["verifyEmailButton"]
        verifyEmailButton.tap()

        XCTAssertTrue(app.staticTexts["emailFieldError"].exists)
        XCTAssertTrue(app.staticTexts["Please enter a valid email"].exists)
    }

    func testErrorMessageHiddenOnReplacedWithValidEmail() throws {
        let app = XCUIApplication()
        assertHeaderText()
        app.tables.staticTexts["btn_testUIControls"].tap()
        XCTAssertEqual(app.staticTexts["headline_label"].title, "")

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].typeText("invalid-email.com")
        let verifyEmailButton = app.buttons["verifyEmailButton"]
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

extension VerifyEmailUITests: LiveResetClientDelegate {
    public func clientShutdown(withFatalError error: Error) {
        print("Fatal error - \(error.localizedDescription)")
        XCTFail(error.localizedDescription)
        XCUIApplication().terminate()
    }

    public func clientOperationFailed(withError error: Error) {
        print("Operation error \(error.localizedDescription)")
    }
}
