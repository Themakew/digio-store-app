//
//  HomeViewModel.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxCocoa
import RxRelay
import RxSwift
import UIKit
import XCoordinator

protocol HomeViewModelProtocol {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}

protocol HomeViewModelInput {
    var getProducts: PublishRelay<Void> { get }
}

protocol HomeViewModelOutput {
    var dataSource: BehaviorRelay<HomeDataSource?> { get }
    var setErrorAlert: PublishRelay<Void> { get }
}

extension HomeViewModelProtocol where Self: HomeViewModelInput & HomeViewModelOutput {
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}

final class HomeViewModel: HomeViewModelProtocol, HomeViewModelInput, HomeViewModelOutput {

    // MARK: - Internal Properties

    // Inputs
    let getProducts = PublishRelay<Void>()

    // Outputs
    let dataSource = BehaviorRelay<HomeDataSource?>(value: nil)
    let setErrorAlert = PublishRelay<Void>()

    // MARK: - Private Properties

    private let router: WeakRouter<HomeRouter>
    private let productsUseCase: ProductsUseCaseProtocol
    private let disposeBag = DisposeBag()

    // MARK: - Initializer

    init(router: WeakRouter<HomeRouter>, productsUseCase: ProductsUseCaseProtocol) {
        self.router = router
        self.productsUseCase = productsUseCase

        bindRx()
    }

    // MARK: - Private Methods

    private func bindRx() {
        let responseResultObservable = getProducts
            .flatMap(weak: self) { this, _ -> Observable<Result<HomeDataSource, NetworkError>> in
                return this.productsUseCase.getProducts()
                    .asObservable()
            }
            .share()

        responseResultObservable
            .withUnretained(self)
            .subscribe(onNext: { this, result in
                switch result {
                case let .success(response):
                    this.dataSource.accept(response)
                case .failure:
                    this.setErrorAlert.accept(())
                }
            })
            .disposed(by: disposeBag)

        let productSelectedObserver = Observable.combineLatest(productsUseCase.spotlightSelectedIndex, productsUseCase.apiResponse)
        productsUseCase.spotlightSelectedIndex
            .withLatestFrom(productSelectedObserver)
            .map({ result -> SpotlightEntity? in
                let index = result.0.item
                return result.1?.spotlight?[index]
            })
            .subscribe(onNext: { [weak self] product in
                if let product,
                   let detailObject = self?.productsUseCase.getDetailObject(object: product) {
                    self?.router.trigger(.detailScreen(object: detailObject))
                }
            })
            .disposed(by: disposeBag)
    }
}
