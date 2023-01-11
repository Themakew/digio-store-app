//
//  ProductsUseCase.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxRelay
import RxSwift

final class ProductsUseCase: ProductsUseCaseProtocol {

    // MARK: - Private Properties

    private let productsRepository: ProductsRepositoryProtocol

    // MARK: - Initializer

    init(productsRepository: ProductsRepositoryProtocol) {
        self.productsRepository = productsRepository
    }

    // MARK: - Internal Methods

    func getProducts() -> Single<Result<HomeDataSource, NetworkError>> {
        return productsRepository.getProducts()
            .map { result -> Result<HomeDataSource, NetworkError> in
                switch result {
                case let .success(object):
                    var dataSource = [DataSource]()
                    dataSource.append(HomeSpotlightSection(items: object.spotlight ?? []))
                    dataSource.append(
                        HomeCashSection(
                            object: object.cash ?? CashEntity(title: "", bannerURL: "", description: "")
                        )
                    )
                    dataSource.append(HomeProductSection(items: object.products ?? []))

                    var dataSourceObject = HomeDataSource(items: dataSource)
                    return .success(dataSourceObject)
                case let .failure(error):
                    return .failure(error)
                }
            }
    }
}
