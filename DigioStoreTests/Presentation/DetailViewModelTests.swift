//
//  DetailViewModelTests.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxBlocking
import XCTest
@testable import DigioStore

final class DetailViewModelTests: XCTestCase {

    // MARK: - Private Properties

    private var sut: DetailViewModelProtocol!
    private var homeCoordinatorSpy: HomeCoordinatorSpy!

    // MARK: - Override Methods

    override func setUp() {
        super.setUp()
        homeCoordinatorSpy = HomeCoordinatorSpy()
        sut = DetailViewModel(
            router: homeCoordinatorSpy.weakRouter,
            detailObject: DetailEntity(
                title: "title",
                imageURL: "imageURL",
                description: "description"
            )
        )
    }

    override func tearDown() {
        sut = nil
        homeCoordinatorSpy = nil
        super.tearDown()
    }

    // MARK: - Test Methods

    func test_titleText_whenDetailObjectIsInjected_shouldReturnCorrectString() throws {
        let result = try sut.output.titleText.toBlocking().first()
        XCTAssertEqual(result, "title")
    }

    func test_description_whenDetailObjectIsInjected_shouldReturnCorrectString() throws {
        let result = try sut.output.descriptionText.toBlocking().first()
        XCTAssertEqual(result, "description")
    }

    func test_imageURL_whenDetailObjectIsInjected_shouldReturnCorrectString() throws {
        let result = try sut.output.image.toBlocking().first()
        XCTAssertEqual(result, "imageURL")
    }

    func test_dismissScreen_whenDismissButtonIsTriggered_shouldEmitDismissRoute() {
        sut.input.dismissScreen.accept(())
        XCTAssertEqual(homeCoordinatorSpy.currentRoute, .dismiss)
    }

    func test_detailObjectWithEmptyProperties_shouldHandleGracefully() {
        let emptyDetailObject = DetailEntity(title: "", imageURL: "", description: "")

        sut = DetailViewModel(
            router: homeCoordinatorSpy.weakRouter,
            detailObject: emptyDetailObject
        )

        do {
            let titleResult = try sut.output.titleText.toBlocking().first()
            let descriptionResult = try sut.output.descriptionText.toBlocking().first()
            let imageURLResult = try sut.output.image.toBlocking().first()

            XCTAssertEqual(titleResult, "", "The title should be empty")
            XCTAssertEqual(descriptionResult, "", "The description should be empty")
            XCTAssertEqual(imageURLResult, "", "The imageURL should be empty")
        } catch {
            XCTFail("The view model should handle empty properties without throwing errors")
        }
    }
}
