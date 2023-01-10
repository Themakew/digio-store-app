//
//  ProductsRepositoryProtocol.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxSwift

protocol ProductsRepositoryProtocol {
    func getProducts() -> Single<Result<ProductsResponse, NetworkError>>
}
