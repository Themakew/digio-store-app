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

    func getProducts() -> Single<Result<HomeDataSource, NetworkError>> {
        return Single<Result<HomeDataSource, NetworkError>>.create { single in
            let resultObject = HomeDataSource(items: [])
            single(.success(.success(resultObject)))
            return Disposables.create()
        }
    }

    func getDetailObject(object: SpotlightEntity) -> DetailEntity {
        return DetailEntity(title: "title", imageURL: "imageURL", description: "description")
    }

    func getDetailObject(object: DigioStore.CashEntity) -> DetailEntity {
        return DetailEntity(title: "title", imageURL: "imageURL", description: "description")
    }

    func getDetailObject(object: DigioStore.ProductEntity) -> DetailEntity {
        return DetailEntity(title: "title", imageURL: "imageURL", description: "description")
    }
}
