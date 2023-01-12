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

    private var sut: DetailViewModelProtocol!

    override func setUp() {
        super.setUp()
        let coor = HomeCoordinator()
        sut = DetailViewModel(
            router: coor.weakRouter,
            detailObject: DetailEntity(
                title: "",
                imageURL: "",
                description: ""
            )
        )
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_titleText_whenDetailObjectIsInject_shouldReturnCorrectString() {
        let result = try? sut.output.titleText.toBlocking().first()
        XCTAssertEqual(result, "")
    }
}
