//
//  HomeViewModelTests.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-13.
//

import RxBlocking
import XCTest
@testable import DigioStore

final class HomeViewModelTests: XCTestCase {

    private var sut: HomeViewModelProtocol!
    private var productsUseCaseStub: ProductsUseCaseProtocol!
    private var errorUseCaseStub: ErrorUseCaseProtocol!

    override func setUp() {
        super.setUp()
        let coor = HomeCoordinator()
        productsUseCaseStub = ProductsUseCaseStub()
        errorUseCaseStub = ErrorUseCaseStub()
        sut = HomeViewModel(
            router: coor.weakRouter,
            productsUseCase: productsUseCaseStub,
            errorUseCase: errorUseCaseStub
        )
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }
//
//    func test_titleText_whenDetailObjectIsInject_shouldReturnCorrectString() {
//        let result = try? sut.output.titleText.toBlocking().first()
//        XCTAssertEqual(result, "Title")
//    }

//    func test_imageURL_whenDetailObjectIsInject_shouldReturnCorrectString() {
//        let result = try? sut.output.image.toBlocking().first()
//        XCTAssertEqual(result, "imageURL")
//    }
//
//    func test_description_whenDetailObjectIsInject_shouldReturnCorrectString() {
//        let result = try? sut.output.descriptionText.toBlocking().first()
//        XCTAssertEqual(result, "description")
//    }
}
