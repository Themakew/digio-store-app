//
//  ProductsAPIService.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxSwift

protocol ProductsAPIServiceProtocol {
    func getProducts() -> Single<Result<ProductsResponse, NetworkError>>
}

enum ActivityAPICall {
    case products

    var path: APIRequest {
        switch self {
        case .products:
            return APIRequest(path: "products")
        }
    }
}

final class ProductsAPIService: ProductsAPIServiceProtocol {

    // MARK: - Private Property

    private let serviceAPI: ServiceAPICallProtocol

    // MARK: - Initializer

    init(serviceAPI: ServiceAPICallProtocol) {
        self.serviceAPI = serviceAPI
    }

    // MARK: - Internal Methods

    func getProducts() -> Single<Result<ProductsResponse, NetworkError>> {
        return serviceAPI.request(requestURL: ActivityAPICall.products.path.url, type: ProductsResponse.self)
    }
}
