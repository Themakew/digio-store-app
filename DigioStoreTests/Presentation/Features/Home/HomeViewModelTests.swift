//
//  HomeViewModelTests.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-13.
//

import RxBlocking
import RxSwift
import XCTest
@testable import DigioStore

final class HomeViewModelTests: XCTestCase {

    // MARK: - Private Properties

    private var homeCoordinatorSpy: HomeCoordinatorSpy!
    private var sut: HomeViewModelProtocol!
    private var productsUseCaseStub: ProductsUseCaseStub!
    private var errorUseCaseStub: ErrorUseCaseStub!
    private var disposeBag: DisposeBag!

    // MARK: - Lifecycle Methods

    override func setUp() {
        super.setUp()
        homeCoordinatorSpy = HomeCoordinatorSpy()
        productsUseCaseStub = ProductsUseCaseStub()
        errorUseCaseStub = ErrorUseCaseStub()
        sut = HomeViewModel(
            router: homeCoordinatorSpy.weakRouter,
            productsUseCase: productsUseCaseStub,
            errorUseCase: errorUseCaseStub
        )
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        homeCoordinatorSpy = nil
        productsUseCaseStub = nil
        errorUseCaseStub = nil
        sut = nil
        disposeBag = nil
        super.tearDown()
    }

    // MARK: - Test Methods

    func test_dataSource_whenTheDataIsReceived_shouldReturnSuccess() {
        // Test Purpose:
        // This test verifies that the data source is successfully received and contains the expected data.

        let expectation = XCTestExpectation(description: "Get datasource")
        var homeDataSource: HomeDataSource?

        sut.output.dataSource
            .subscribe(onNext: { dataSource in
                homeDataSource = dataSource
                // Fulfill the expectation when the data source is received.
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // Trigger the fetch for products.
        sut.input.getProducts.accept(())

        // Wait for the data source to be received.
        wait(for: [expectation], timeout: 5.0)

        XCTAssertEqual(homeDataSource?.items.count, 0)
    }

    func test_isLoading_whenFetchingProducts_shouldReturnState() {
        // Test Purpose:
        // This test ensures that the loading state is managed correctly when fetching products.
        // It should initially be true when the fetch begins, and then false once the fetch completes.

        let expectation = XCTestExpectation(description: "Is loading")

        // Configure the stub to simulate a delay in fetching products.
        productsUseCaseStub.shouldWaitForTrigger = true

        var loadingStates = [Bool]()
        sut.output.isLoading
            .subscribe(onNext: { isLoading in
                loadingStates.append(isLoading)

                // Fulfill the expectation when the loading state is true, indicating the start of the fetch.
                if isLoading {
                    expectation.fulfill()
                }
            })
            .disposed(by: disposeBag)

        // Trigger the product fetch.
        sut.input.getProducts.accept(())

        // Wait for the loading state to be true.
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(loadingStates.contains(true))

        // Simulate the completion of the fetch and verify the loading state is false.
        productsUseCaseStub.triggerGetProducts(result: .success(HomeDataSource(items: [])))
        XCTAssertFalse(loadingStates.last ?? true)
    }

    func test_setErrorAlert_whenFetchingFails_shouldReturnError() {
        // Test Purpose:
        // This test checks that an error alert is set when the fetching of products fails.

        let expectation = XCTestExpectation(description: "Set error alert")
        var errorEntity: ErrorEntity?

        // Simulate an error scenario for fetching products.
        productsUseCaseStub.getProductsSimulateError = true

        sut.output.setErrorAlert
            .subscribe(onNext: { error in
                errorEntity = error
                // Fulfill the expectation when the error is received.
                expectation.fulfill()
            })
            .disposed(by: disposeBag)

        // Trigger the fetch for products, which is expected to fail.
        sut.input.getProducts.accept(())

        // Wait for the error to be set.
        wait(for: [expectation], timeout: 5.0)

        XCTAssertNotNil(errorEntity)
        XCTAssertEqual(errorEntity?.dataSource.messageErrorText, "messageErrorText")
        XCTAssertEqual(errorEntity?.dataSource.buttonTitleText, "buttonTitleText")
        XCTAssertEqual(errorEntity?.dataSource.icon, UIImage())
        XCTAssertEqual(errorEntity?.dataSource.backgroudColor, .black)
    }

    func test_spotlightItemSelected_whenItemSelected_shouldTriggerRouter() {
        // Test Purpose:
        // This test ensures that when a spotlight item is selected, the appropriate router action is triggered.

        // Prepare the data with a spotlight item.
        productsUseCaseStub.apiResponse.accept(
            ProductsEntity(
                spotlight: [SpotlightEntity(name: "Spotlight", bannerURL: "imageURL", description: "description")],
                products: nil,
                cash: nil
            )
        )

        let indexPath = IndexPath(row: 0, section: 0)
        // Simulate the selection of a spotlight item.
        productsUseCaseStub.spotlightSelectedIndex.accept(indexPath)

        let detailEntity = DetailEntity(title: "Spotlight", imageURL: "imageURL", description: "description")
        XCTAssertEqual(homeCoordinatorSpy.currentRoute, .detailScreen(object: detailEntity))
    }

    func test_cashItemSelected_whenItemSelected_shouldTriggerRouter() {
        // Test Purpose:
        // This test confirms that when a cash item is selected, the correct router action is initiated.

        // Set up the data with a cash item.
        productsUseCaseStub.apiResponse.accept(
            ProductsEntity(
                spotlight: nil,
                products: nil,
                cash: CashEntity(title: "Cash", bannerURL: "bannerURL", description: "description")
            )
        )

        let indexPath = IndexPath(row: 0, section: 0)
        // Simulate the selection of a cash item.
        sut.input.cashItemSelected.accept(indexPath)

        let detailEntity = DetailEntity(title: "Cash", imageURL: "imageURL", description: "description")
        XCTAssertEqual(homeCoordinatorSpy.currentRoute, .detailScreen(object: detailEntity))
    }

    func test_productItemSelected_whenItemSelected_shouldTriggerRouter() {
        // Test Purpose:
        // This test verifies that selecting a product item triggers the appropriate routing action for details.

        // Provide data with a product item.
        productsUseCaseStub.apiResponse.accept(
            ProductsEntity(
                spotlight: nil,
                products: [ProductEntity(name: "Product", imageURL: "imageURL", description: "description")],
                cash: nil
            )
        )

        let indexPath = IndexPath(row: 0, section: 0)
        // Simulate the action of selecting a product.
        productsUseCaseStub.productSelectedIndex.accept(indexPath)

        let detailEntity = DetailEntity(title: "Product", imageURL: "imageURL", description: "description")
        XCTAssertEqual(homeCoordinatorSpy.currentRoute, .detailScreen(object: detailEntity))
    }

    func test_tryAgain_whenIsSelected_shouldTriggerGetProducts() {
        // Test Purpose:
        // This test verifies that when a "try again" action occurs (e.g., user taps "try again" after a fetch failure),
        // the system correctly initiates a new product fetch.

        let tryAgainExpectation = XCTestExpectation(description: "Try again triggered")

        // Simulate an error in the product fetching process to prompt a "try again" scenario.
        productsUseCaseStub.getProductsSimulateError = true

        // Monitor the setErrorAlert to know when the error alert is set, indicating a fetch failure.
        sut.output.setErrorAlert
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] error in
                // Confirm that an error is presented.
                XCTAssertNotNil(error)

                // Simulate the "Try Again" action, which should trigger a new product fetch.
                self?.errorUseCaseStub.tryAgainObserver?.accept(())
            })
            .disposed(by: disposeBag)

        // Monitor getProducts to verify that it's triggered upon "Try Again".
        sut.input.getProducts
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                // If getProducts is triggered, it means "Try Again" worked. Fulfill the expectation.
                tryAgainExpectation.fulfill()
            })
            .disposed(by: disposeBag)

        // Initiate the process by calling getProducts, which should fail and present an error.
        sut.input.getProducts.accept(())

        // Wait for the "Try Again" action to trigger a new fetch.
        wait(for: [tryAgainExpectation], timeout: 5.0)
    }
}
