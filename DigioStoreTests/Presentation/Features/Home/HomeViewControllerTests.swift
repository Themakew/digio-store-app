//
//  HomeViewControllerTests.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-17.
//

import RxRelay
import RxSwift
import XCTest
@testable import DigioStore

final class HomeViewControllerTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: HomeViewController!
    private var homeViewModelStub: HomeViewModelStub!
    private var disposeBag: DisposeBag!

    // MARK: - Lifecycle Methods

    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        homeViewModelStub = HomeViewModelStub()
        sut = HomeViewController(
            viewModel: homeViewModelStub
        )
    }

    override func tearDown() {
        sut = nil
        homeViewModelStub = nil
        disposeBag = nil
        super.tearDown()
    }

    // MARK: - Test Methods

    func test_viewModelBindings_whenIsTriggered_shouldBindingSuccessfully() throws {
        // Test Purpose:
        // This test retrieves the actual values from the ViewModel's Driver streams
        // when the view is the loading state.

        sut.loadViewIfNeeded()

        XCTAssertFalse(sut.getSpinnerView().isHidden)
        XCTAssertTrue(sut.getSpinnerIndicatorView().isAnimating)
        XCTAssertFalse(sut.getErrorView().isDescendant(of: sut.view), "The errorView should be a subview of the view controller's view when an error occurs")
    }

    func test_errorView_whenIsDisplayed_whenViewModelEmitsError() {
        // Test Purpose:
        // This test verifies if the HomeViewController handles the views state gracefully.

        // Load the view controller's view.
        sut.loadViewIfNeeded()

        // Configure the ViewModel stub to emit an error.
        let mockedErrorEntity = ErrorEntity(
            dataSource:
                GenericErrorEntity(
                    messageErrorText: "messageErrorText",
                    buttonTitleText: "buttonTitleText",
                    icon: UIImage(),
                    backgroudColor: .white
                ),
            tryAgainObserver: PublishRelay<Void>(),
            isShown: BehaviorRelay<Bool>(value: false)
        )

        homeViewModelStub.setErrorAlert.accept(mockedErrorEntity)

        XCTAssertTrue(sut.getErrorView().isDescendant(of: sut.view), "The errorView should be displayed when there is an error")
        XCTAssertEqual(sut.getErrorView().getMessageErrorLabelText(), mockedErrorEntity.dataSource.messageErrorText)
        XCTAssertEqual(sut.getErrorView().getTryAgainTextLabelText(), mockedErrorEntity.dataSource.buttonTitleText)
        XCTAssertEqual(sut.getErrorView().getBackgroundColor(), mockedErrorEntity.dataSource.backgroudColor)
    }

    func test_collectionViewDataBinding_whenGetDataIsTriggered_whenViewModelEmitsData() {
        // Test Purpose:
        // This test verifies if the HomeViewController handles the collectionView binding gracefully.

        // Load the view controller's view.
        sut.loadViewIfNeeded()

        // Mock data to be emitted by the ViewModel.
        let mockData = HomeDataSource(items: [
            HomeSpotlightSection(
                items: [
                    SpotlightEntity(name: "spotlight", bannerURL: "bannerURL", description: "description")
                ],
                itemSelectedObserver: PublishRelay<IndexPath>()
            ),
        ])

        homeViewModelStub.dataSource.accept(mockData)

        XCTAssertEqual(sut.getCollectionView().numberOfItems(inSection: 0), 1, "The collectionView should display the correct number of items")
    }
}
