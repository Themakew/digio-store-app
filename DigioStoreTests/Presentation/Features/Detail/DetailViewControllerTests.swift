//
//  DetailViewControllerTests.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-16.
//

import RxSwift
import XCTest
@testable import DigioStore

final class DetailViewControllerTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: DetailViewController!
    private var detailViewModelStub: DetailViewModelStub!
    private var disposeBag: DisposeBag!

    // MARK: - Lifecycle Methods

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        detailViewModelStub = DetailViewModelStub()
        sut = DetailViewController(
            viewModel: detailViewModelStub
        )
    }

    override func tearDown() {
        sut = nil
        detailViewModelStub = nil
        disposeBag = nil
        super.tearDown()
    }

    // MARK: - Test Methods

    func test_viewModelBindings_whenIsTriggred_shouldBindingSuccessfully() throws {
        // Test Purpose:
        // This test retrieves the actual values from the ViewModel's Driver streams.

        let actualTitle = try detailViewModelStub.titleText.toBlocking().first()
        let actualDescription = try detailViewModelStub.descriptionText.toBlocking().first()

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.title, actualTitle)
        XCTAssertEqual(sut.getDescriptionLabel().text, actualDescription)
    }

    func test_dismissScreen_whenIsSelected_shouldTriggerDismissScreen() {
        // Test Purpose:
        // This test verifies that when a "dismiss screen" action occurs, the correct binding works.

        let expectation = XCTestExpectation(description: "Get dismiss screen action")
        var isDismissCalled = false

        sut.loadViewIfNeeded()

        detailViewModelStub.input.dismissScreen
            .subscribe(onNext: { _ in
                isDismissCalled = true
                // Fulfill the expectation when the data source is received.
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // Assuming there's a way to simulate a tap on the back button
        // This might involve calling a method on the button or using a gesture recognizer
        sut.getBackNavButton().sendActions(for: .touchUpInside)

        // Check if the correct method on the ViewModel was called
        // This might involve checking a flag or a method call count
        XCTAssertTrue(isDismissCalled)
    }
}
