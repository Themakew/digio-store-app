//
//  ProductsRepository.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxSwift

final class ProductsRepository: ProductsRepositoryProtocol {

    // MARK: - Private Properties

    private let productsService: ProductsAPIServiceProtocol

    // MARK: - Initializer

    init(productsService: ProductsAPIServiceProtocol) {
        self.productsService = productsService
    }

    // MARK: - Internal Methods

    func getProducts() -> Single<Result<ProductsResponse, NetworkError>> {
        return productsService.getProducts()
    }
}
