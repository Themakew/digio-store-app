//
//  DigioStoreUITests.swift
//  DigioStoreUITests
//
//  Created by Ruyther Costa on 09/01/23.
//

import XCTest

final class DigioStoreUITests: XCTestCase {

    private let app = XCUIApplication()

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        // Launching the app once for all tests in this class to use
        app.launch()
    }

    override func tearDownWithError() throws {
        // Any necessary cleanup after tests are done
        try super.tearDownWithError()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                // The app is already launched, so this might not be necessary
                // unless you specifically want to measure launch performance multiple times.
            }
        }
    }

    func testLaunchScreenAppearance() throws {
        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
