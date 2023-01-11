//
//  ProductsUseCaseProtocol.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation
import RxRelay
import RxSwift

protocol ProductsUseCaseProtocol {
    var spotlightSelectedIndex: PublishRelay<IndexPath> { get }
    var productSelectedIndex: PublishRelay<IndexPath> { get }
    var apiResponse: BehaviorRelay<ProductsEntity?> { get }

    func getProducts() -> Single<Result<HomeDataSource, NetworkError>>
    func getDetailObject(object: SpotlightEntity) -> DetailEntity
    func getDetailObject(object: CashEntity) -> DetailEntity
    func getDetailObject(object: ProductEntity) -> DetailEntity
}
