//
//  URLSession+Misc.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation

extension URLSession: URLSessionProtocol {
    func requestData(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTaskProtocol {
        return dataTask(with: url, completionHandler: completionHandler)
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
