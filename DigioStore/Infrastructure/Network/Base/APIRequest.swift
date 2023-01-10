//
//  APIRequest.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation

enum BaseURL: String {
    case primary = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/"
}

struct APIRequest {

    // MARK: - Internal Properties

    let url: String

    // MARK: - Private Properties

    private let baseURL: BaseURL
    private let path: String

    // MARK: - Initializer

    init(
        path: String,
        baseURL: BaseURL = .primary
    ) {
        self.baseURL = baseURL
        self.path = path
        self.url = baseURL.rawValue + path
    }
}
