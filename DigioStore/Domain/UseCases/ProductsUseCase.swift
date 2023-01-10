//
//  ProductsUseCase.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxSwift

final class ProductsUseCase: ProductsUseCaseProtocol {

    // MARK: - Private Properties

    private let productsRepository: ProductsRepositoryProtocol

    // MARK: - Initializer

    init(productsRepository: ProductsRepositoryProtocol) {
        self.productsRepository = productsRepository
    }

    // MARK: - Internal Methods

    func getProducts() -> Single<Result<ProductsResponse, NetworkError>> {
        return productsRepository.getProducts()
    }
}
