//
//  ProductsAPIServiceTests.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxBlocking
import RxSwift
import XCTest
@testable import DigioStore

final class ProductsAPIServiceTests: XCTestCase {

    private var sut: ServiceAPICallProtocol!
    private var sessionStub: SessionStub!
    private var dummyData: Data? {
        """
        {
          "spotlight": [
            {
              "name": "name",
              "bannerURL": "bannerURL",
              "description": "description"
            }
          ],
          "products": [
            {
              "name": "name",
              "imageURL": "imageURL",
              "description": "description"
            }
          ],
          "cash": {
            "title": "title",
            "bannerURL": "bannerURL",
            "description": "description"
          }
        }
        """.data(using: .utf8)
    }

    override func setUp() {
        super.setUp()
        sessionStub = SessionStub()
        sut = ServiceAPICall(session: sessionStub)
    }

    override func tearDown() {
        super.tearDown()
        sessionStub = nil
        sut = nil
    }

    func test_productsRequest_whenIsRequestedData_shouldReturnSuccess() {
        sessionStub.nextData = dummyData

        do {
            let decodeMockData = try JSONDecoder().decode(ProductsResponse.self, from: dummyData ?? Data())
            let result = try sut.request(requestURL: "test.com", type: ProductsResponse.self).toBlocking().first()

            switch result {
            case let .success(object):
                XCTAssertEqual(object, decodeMockData)
            default:
                XCTFail("test_productsRequest_whenIsRequestedData_shouldReturnSuccess failed")
            }
        } catch {
            XCTFail("test_productsRequest_whenIsRequestedData_shouldReturnSuccess failed")
        }
    }
}
