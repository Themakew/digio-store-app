//
//  ProductsUseCase.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation
import RxRelay
import RxSwift

final class ProductsUseCase: ProductsUseCaseProtocol {

    // MARK: - Internal Properties

    let spotlightSelectedIndex = PublishRelay<IndexPath>()
    let productSelectedIndex = PublishRelay<IndexPath>()
    let apiResponse = BehaviorRelay<ProductsEntity?>(value: nil)

    // MARK: - Private Properties

    private let productsRepository: ProductsRepositoryProtocol

    // MARK: - Initializer

    init(productsRepository: ProductsRepositoryProtocol) {
        self.productsRepository = productsRepository
    }

    // MARK: - Internal Methods

    func getProducts() -> Single<Result<HomeDataSource, NetworkError>> {
        return productsRepository.getProducts()
            .map { [weak self] result -> Result<HomeDataSource, NetworkError> in
                guard let self else {
                    return .failure(
                        NetworkError.genericError(
                            error: "ProductsAPIService has a strong reference"
                        )
                    )
                }

                switch result {
                case let .success(object):
                    self.apiResponse.accept(object)

                    var dataSource = [DataSource]()
                    dataSource.append(
                        HomeSpotlightSection(
                            items: object.spotlight ?? [],
                            itemSelectedObserver: self.spotlightSelectedIndex
                        )
                    )
                    dataSource.append(TitleEntity(title: "digio Cash"))
                    dataSource.append(
                        HomeCashSection(
                            object: object.cash ?? CashEntity(title: "", bannerURL: "", description: "")
                        )
                    )
                    dataSource.append(TitleEntity(title: "Produtos"))
                    dataSource.append(
                        HomeProductSection(
                            items: object.products ?? [],
                            itemSelectedObserver: self.productSelectedIndex
                        )
                    )

                    let dataSourceObject = HomeDataSource(items: dataSource)
                    return .success(dataSourceObject)
                case let .failure(error):
                    return .failure(error)
                }
            }
    }

    func getDetailObject(object: SpotlightEntity) -> DetailEntity {
        return DetailEntity(
            title: object.name,
            imageURL: object.bannerURL,
            description: object.description
        )
    }

    func getDetailObject(object: CashEntity) -> DetailEntity {
        return DetailEntity(
            title: object.title,
            imageURL: object.bannerURL,
            description: object.description
        )
    }

    func getDetailObject(object: ProductEntity) -> DetailEntity {
        return DetailEntity(
            title: object.name,
            imageURL: object.imageURL,
            description: object.description
        )
    }
}
