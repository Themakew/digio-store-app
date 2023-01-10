//
//  NetworkError.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case httpResponseError(statusCode: Int)
    case decodeError
    case genericError(error: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .urlError:
            return "Network Error: Invalid URL"
        case let .httpResponseError(statusCode):
            return "Network Error: HTTP Code \(statusCode)"
        case .decodeError:
            return "Network Error: Decode Error"
        case let .genericError(error):
            return "Network Error: \(error)"
        }
    }
}
