//
//  URLSessionProtocol.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation

protocol URLSessionProtocol {
    func requestData(
        with url: URL,
        completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
    func resume()
    func cancel()
}
