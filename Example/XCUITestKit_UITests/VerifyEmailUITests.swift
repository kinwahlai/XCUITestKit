//
//  VerifyEmailUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/8/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest

class VerifyEmailUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
        print("SIMULATOR_UDID >>>>>>>>>>>> \(String(describing: ProcessInfo.processInfo.environment["SIMULATOR_UDID"]))")
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
        guard let stringValue = self.value as? String else {
            return
        }

        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        typeText(deleteString)
    }
}
