//
//  LoadUITests.swift
//  XCUITestKit_UITests
//
//  Created by Darren Lai on 7/27/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import XCUITestLiveReset

func assertgRPCServerStarted() {
    let app = XCUIApplication()
    XCTAssertTrue(app.staticTexts["gRPC server started on port: \(LiveResetClient.shared.port)"].exists)
    XCTAssertTrue(app.staticTexts["\(LiveResetClient.shared.netServiceName)"].exists)
}

class LoadUITests: TestBaseWithLiveReset {
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {}

    func actualTestFunction() throws {
        let app = XCUIApplication()
        XCTAssertTrue(app.navigationBars["XCUITestKit Example"].staticTexts["XCUITestKit Example"].exists)

        assertgRPCServerStarted()

        app.tables.staticTexts["btn_testUIControls"].tap()
        XCTAssertEqual(app.staticTexts["headline_label"].title, "")

        app.textFields["email_textfield"].tap()
        app.textFields["email_textfield"].typeText("valid@email.com")
        let verifyEmailButton = app.buttons["verifyEmailButton"].staticTexts["verify email"]
        verifyEmailButton.tap()

        XCTAssertFalse(app.staticTexts["emailFieldError"].exists)
    }

    func testLoad_01() throws { try actualTestFunction() }
    func testLoad_02() throws { try actualTestFunction() }
    func testLoad_03() throws { try actualTestFunction() }
    func testLoad_04() throws { try actualTestFunction() }
    func testLoad_05() throws { try actualTestFunction() }
    func testLoad_06() throws { try actualTestFunction() }
    func testLoad_07() throws { try actualTestFunction() }
    func testLoad_08() throws { try actualTestFunction() }
    func testLoad_09() throws { try actualTestFunction() }
    func testLoad_10() throws { try actualTestFunction() }
//    func testLoad_11() throws { try actualTestFunction() }
//    func testLoad_12() throws { try actualTestFunction() }
//    func testLoad_13() throws { try actualTestFunction() }
//    func testLoad_14() throws { try actualTestFunction() }
//    func testLoad_15() throws { try actualTestFunction() }
//    func testLoad_16() throws { try actualTestFunction() }
//    func testLoad_17() throws { try actualTestFunction() }
//    func testLoad_18() throws { try actualTestFunction() }
//    func testLoad_19() throws { try actualTestFunction() }
//    func testLoad_20() throws { try actualTestFunction() }
//    func testLoad_21() throws { try actualTestFunction() }
//    func testLoad_22() throws { try actualTestFunction() }
//    func testLoad_23() throws { try actualTestFunction() }
//    func testLoad_24() throws { try actualTestFunction() }
//    func testLoad_25() throws { try actualTestFunction() }
//    func testLoad_26() throws { try actualTestFunction() }
//    func testLoad_27() throws { try actualTestFunction() }
//    func testLoad_28() throws { try actualTestFunction() }
//    func testLoad_29() throws { try actualTestFunction() }
//    func testLoad_30() throws { try actualTestFunction() }
//    func testLoad_31() throws { try actualTestFunction() }
//    func testLoad_32() throws { try actualTestFunction() }
//    func testLoad_33() throws { try actualTestFunction() }
//    func testLoad_34() throws { try actualTestFunction() }
//    func testLoad_35() throws { try actualTestFunction() }
//    func testLoad_36() throws { try actualTestFunction() }
//    func testLoad_37() throws { try actualTestFunction() }
//    func testLoad_38() throws { try actualTestFunction() }
//    func testLoad_39() throws { try actualTestFunction() }
//    func testLoad_40() throws { try actualTestFunction() }
//    func testLoad_41() throws { try actualTestFunction() }
//    func testLoad_42() throws { try actualTestFunction() }
//    func testLoad_43() throws { try actualTestFunction() }
//    func testLoad_44() throws { try actualTestFunction() }
//    func testLoad_45() throws { try actualTestFunction() }
//    func testLoad_46() throws { try actualTestFunction() }
//    func testLoad_47() throws { try actualTestFunction() }
//    func testLoad_48() throws { try actualTestFunction() }
//    func testLoad_49() throws { try actualTestFunction() }
//    func testLoad_50() throws { try actualTestFunction() }
//    func testLoad_51() throws { try actualTestFunction() }
//    func testLoad_52() throws { try actualTestFunction() }
//    func testLoad_53() throws { try actualTestFunction() }
//    func testLoad_54() throws { try actualTestFunction() }
//    func testLoad_55() throws { try actualTestFunction() }
//    func testLoad_56() throws { try actualTestFunction() }
//    func testLoad_57() throws { try actualTestFunction() }
//    func testLoad_58() throws { try actualTestFunction() }
//    func testLoad_59() throws { try actualTestFunction() }
//    func testLoad_60() throws { try actualTestFunction() }
//    func testLoad_61() throws { try actualTestFunction() }
//    func testLoad_62() throws { try actualTestFunction() }
//    func testLoad_63() throws { try actualTestFunction() }
//    func testLoad_64() throws { try actualTestFunction() }
//    func testLoad_65() throws { try actualTestFunction() }
//    func testLoad_66() throws { try actualTestFunction() }
//    func testLoad_67() throws { try actualTestFunction() }
//    func testLoad_68() throws { try actualTestFunction() }
//    func testLoad_69() throws { try actualTestFunction() }
//    func testLoad_70() throws { try actualTestFunction() }
//    func testLoad_71() throws { try actualTestFunction() }
//    func testLoad_72() throws { try actualTestFunction() }
//    func testLoad_73() throws { try actualTestFunction() }
//    func testLoad_74() throws { try actualTestFunction() }
//    func testLoad_75() throws { try actualTestFunction() }
//    func testLoad_76() throws { try actualTestFunction() }
//    func testLoad_77() throws { try actualTestFunction() }
//    func testLoad_78() throws { try actualTestFunction() }
//    func testLoad_79() throws { try actualTestFunction() }
//    func testLoad_80() throws { try actualTestFunction() }
//    func testLoad_81() throws { try actualTestFunction() }
//    func testLoad_82() throws { try actualTestFunction() }
//    func testLoad_83() throws { try actualTestFunction() }
//    func testLoad_84() throws { try actualTestFunction() }
//    func testLoad_85() throws { try actualTestFunction() }
//    func testLoad_86() throws { try actualTestFunction() }
//    func testLoad_87() throws { try actualTestFunction() }
//    func testLoad_88() throws { try actualTestFunction() }
//    func testLoad_89() throws { try actualTestFunction() }
//    func testLoad_90() throws { try actualTestFunction() }
//    func testLoad_91() throws { try actualTestFunction() }
//    func testLoad_92() throws { try actualTestFunction() }
//    func testLoad_93() throws { try actualTestFunction() }
//    func testLoad_94() throws { try actualTestFunction() }
//    func testLoad_95() throws { try actualTestFunction() }
//    func testLoad_96() throws { try actualTestFunction() }
//    func testLoad_97() throws { try actualTestFunction() }
//    func testLoad_98() throws { try actualTestFunction() }
//    func testLoad_99() throws { try actualTestFunction() }
//    func testLoad_100() throws { try actualTestFunction() }
}
