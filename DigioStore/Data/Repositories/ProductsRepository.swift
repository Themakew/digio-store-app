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

    func getProducts() -> Single<Result<ProductsEntity, NetworkError>> {
        return productsService.getProducts()
            .flatMap { [weak self] result -> Single<Result<ProductsEntity, NetworkError>> in
                guard let self else {
                    return Single<Result<ProductsEntity, NetworkError>>.create { single in
                        single(
                            .success(
                                .failure(
                                    NetworkError.genericError(
                                        error: "ProductsAPIService has a strong reference"
                                    )
                                )
                            )
                        )
                        return Disposables.create()
                    }
                }

                switch result {
                case let .success(object):
                    return Single<Result<ProductsEntity, NetworkError>>.create { single in
                        single(.success(.success(self.getProductEntity(object: object))))
                        return Disposables.create()
                    }
                case let .failure(error):
                    return Single<Result<ProductsEntity, NetworkError>>.create { single in
                        single(.success(.failure(error)))
                        return Disposables.create()
                    }
                }
            }
    }

    // MARK: - Private Methods

    private func getProductEntity(object: ProductsResponse) -> ProductsEntity {
        return ProductsEntity(
            spotlight: getSpotlightList(object: object.spotlight ?? []),
            products: getProductList(object: object.products ?? []),
            cash: getCashEntity(object: object.cash)
        )
    }

    private func getSpotlightList(object: [Spotlight?]) -> [SpotlightEntity] {
        return object.map { item in
            SpotlightEntity(name: item?.name, bannerURL: item?.bannerURL, description: item?.description)
        }
    }

    private func getProductList(object: [Product?]) -> [ProductEntity] {
        return object.map { item in
            ProductEntity(name: item?.name, imageURL: item?.imageURL, description: item?.description)
        }
    }

    private func getCashEntity(object: Cash?) -> CashEntity {
        return CashEntity(title: object?.title, bannerURL: object?.bannerURL, description: object?.description)
    }
}
