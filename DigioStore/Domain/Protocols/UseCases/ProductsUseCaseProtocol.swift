//
//  ProductsUseCaseProtocol.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxSwift

protocol ProductsUseCaseProtocol {
    func getProducts() -> Single<Result<HomeDataSource, NetworkError>>
}
