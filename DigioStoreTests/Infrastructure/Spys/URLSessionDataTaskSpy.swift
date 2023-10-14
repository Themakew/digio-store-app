//
//  URLSessionDataTaskSpy.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 11/01/23.
//

@testable import DigioStore

final class URLSessionDataTaskSpy: URLSessionDataTaskProtocol {
    private(set) var resumeWasCalled = false
    private(set) var cancelWasCalled = false

    func resume() {
        resumeWasCalled = true
    }

    func cancel() {
        cancelWasCalled = true
    }
}
