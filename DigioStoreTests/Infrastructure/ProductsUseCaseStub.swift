//
//  ProductsUseCaseStub.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-13.
//

import Foundation
import RxRelay
import RxSwift
@testable import DigioStore

final class ProductsUseCaseStub: ProductsUseCaseProtocol {

    var spotlightSelectedIndex = PublishRelay<IndexPath>()
    var productSelectedIndex = PublishRelay<IndexPath>()
    var apiResponse = BehaviorRelay<ProductsEntity?>(value: nil)
    var resultObjectInjected = HomeDataSource(items: [])

    var getProductsSimulateError = false
    var shouldWaitForTrigger = false

    private let getProductsSubject = PublishSubject<Result<HomeDataSource, NetworkError>>()

    func getProducts() -> Single<Result<HomeDataSource, NetworkError>> {
        guard !shouldWaitForTrigger else {
            return getProductsSubject
                .take(1)
                .asSingle()
        }

        guard !getProductsSimulateError else {
            return .just(.failure(.decodeError))
        }

        return .just(.success(resultObjectInjected))
    }

    func getDetailObject(object: SpotlightEntity) -> DetailEntity {
        return DetailEntity(
            title: object.name ?? "",
            imageURL: object.bannerURL ?? "",
            description: object.description ?? ""
        )
    }

    func getDetailObject(object: CashEntity) -> DetailEntity {
        return DetailEntity(
            title: object.title ?? "",
            imageURL: object.bannerURL ?? "",
            description: object.description ?? ""
        )
    }

    func getDetailObject(object: ProductEntity) -> DetailEntity {
        return DetailEntity(
            title: object.name ?? "",
            imageURL: object.imageURL ?? "",
            description: object.description ?? ""
        )
    }

    func triggerGetProducts(result: Result<HomeDataSource, NetworkError>) {
        getProductsSubject.onNext(result)
        getProductsSubject.onCompleted()
    }
}
