//
//  TestBaseWithLiveReset.swift
//  XCUITestLiveReset-Base-Client
//
//  Created by Darren Lai on 8/2/20.
//

import XCTest

open class TestBaseWithLiveReset: XCTestCase {
    /*
     You can also use the normal way like this
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
     */

    /*
     Use a static variable to keep and store the client across all tests
     otherwise it wont have the effect of reset the application without relaunch
        if VerifyEmailUITests.client == nil {
            VerifyEmailUITests.client = LiveResetClient.with {
                $0.app = app
                $0.launchEnvironment["custom"] = "value"
            }
            .build()
            VerifyEmailUITests.client.resetOrLaunch()
        }
     */

    // or let handle it via share() function
    //  try super.setUpWithError()

    open override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        LiveResetClient.with {
            $0.app = app
        }
        .share()
        .resetOrLaunch()
    }
}
