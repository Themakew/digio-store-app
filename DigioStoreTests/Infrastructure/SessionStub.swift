//
//  SessionStub.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 11/01/23.
//

import Foundation
@testable import DigioStore

final class SessionStub: URLSessionProtocol {

    // MARK: - Internal Methods

    var nextDataTask = URLSessionDataTaskSpy()
    var nextData: Data?
    var nextError: Error?
    var lastURL: URL?
    var isResponseError = false

    // MARK: - Internal Methods

    func successHttpURLResponse(url: URL) -> URLResponse {
        if isResponseError {
            return HTTPURLResponse(url: url, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
        } else {
            return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        }
    }

    func requestData(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        lastURL = url

        completionHandler(nextData, successHttpURLResponse(url: url), nextError)
        return nextDataTask
    }
}
