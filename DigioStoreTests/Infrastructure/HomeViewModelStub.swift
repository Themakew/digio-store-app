//
//  HomeViewModelStub.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-16.
//

import RxRelay
@testable import DigioStore

final class HomeViewModelStub: HomeViewModelProtocol, HomeViewModelInput, HomeViewModelOutput {
    var getProducts = PublishRelay<Void>()
    var cashItemSelected = PublishRelay<IndexPath>()
    var dataSource = BehaviorRelay<HomeDataSource?>(value: nil)
    var setErrorAlert = PublishRelay<ErrorEntity?>()
    var isLoading = BehaviorRelay<Bool>(value: false)
}
