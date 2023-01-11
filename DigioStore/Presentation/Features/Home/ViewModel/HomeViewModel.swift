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
    var cashItemSelected: PublishRelay<IndexPath> { get }
}

protocol HomeViewModelOutput {
    var dataSource: BehaviorRelay<HomeDataSource?> { get }
    var setErrorAlert: PublishRelay<ErrorEntity?> { get }
}

extension HomeViewModelProtocol where Self: HomeViewModelInput & HomeViewModelOutput {
    var input: HomeViewModelInput { return self }
    var output: HomeViewModelOutput { return self }
}

final class HomeViewModel: HomeViewModelProtocol, HomeViewModelInput, HomeViewModelOutput {

    // MARK: - Internal Properties

    // Inputs
    let getProducts = PublishRelay<Void>()
    let cashItemSelected = PublishRelay<IndexPath>()

    // Outputs
    let dataSource = BehaviorRelay<HomeDataSource?>(value: nil)
    let setErrorAlert = PublishRelay<ErrorEntity?>()

    // MARK: - Private Properties

    private let router: WeakRouter<HomeRouter>
    private let productsUseCase: ProductsUseCaseProtocol
    private let errorUseCase: ErrorUseCaseProtocol
    private let disposeBag = DisposeBag()
    private let tryAgainObservable = PublishRelay<Void>()

    // MARK: - Initializer

    init(
        router: WeakRouter<HomeRouter>,
        productsUseCase: ProductsUseCaseProtocol,
        errorUseCase: ErrorUseCaseProtocol
    ) {
        self.router = router
        self.productsUseCase = productsUseCase
        self.errorUseCase = errorUseCase

        bindRx()
    }

    // MARK: - Private Methods

    private func bindRx() {
        let responseResultObservable = getProducts
            .debug()
            .flatMap(weak: self) { this, _ -> Observable<Result<HomeDataSource, NetworkError>> in
                return this.productsUseCase.getProducts()
                    .asObservable()
            }
            .share()

        responseResultObservable
            .debug()
            .withUnretained(self)
            .subscribe(onNext: { this, result in
                switch result {
                case let .success(response):
                    this.dataSource.accept(response)
                case .failure:
                    this.setErrorAlert.accept(
                        this.errorUseCase.getErrorData(
                            tryAgainObserver: this.tryAgainObservable,
                            isShown: BehaviorRelay<Bool>(value: true)
                        )
                    )
                }
            })
            .disposed(by: disposeBag)

        let spotlightSelectedObserver = Observable.combineLatest(productsUseCase.spotlightSelectedIndex, productsUseCase.apiResponse)
        productsUseCase.spotlightSelectedIndex
            .withLatestFrom(spotlightSelectedObserver)
            .map({ result -> SpotlightEntity? in
                let index = result.0.item
                return result.1?.spotlight?[index]
            })
            .subscribe(onNext: { [weak self] spotlight in
                if let spotlight,
                   let detailObject = self?.productsUseCase.getDetailObject(object: spotlight) {
                    self?.router.trigger(.detailScreen(object: detailObject))
                }
            })
            .disposed(by: disposeBag)

        let cashSelectedObserver = Observable.combineLatest(cashItemSelected, productsUseCase.apiResponse)
        cashItemSelected
            .withLatestFrom(cashSelectedObserver)
            .map { $0.1?.cash }
            .subscribe(onNext: { [weak self] cash in
                if let cash,
                   let detailObject = self?.productsUseCase.getDetailObject(object: cash) {
                    self?.router.trigger(.detailScreen(object: detailObject))
                }
            })
            .disposed(by: disposeBag)

        let productSelectedObserver = Observable.combineLatest(productsUseCase.productSelectedIndex, productsUseCase.apiResponse)
        productsUseCase.productSelectedIndex
            .withLatestFrom(productSelectedObserver)
            .map({ result -> ProductEntity? in
                let index = result.0.item
                return result.1?.products?[index]
            })
            .subscribe(onNext: { [weak self] product in
                if let product,
                   let detailObject = self?.productsUseCase.getDetailObject(object: product) {
                    self?.router.trigger(.detailScreen(object: detailObject))
                }
            })
            .disposed(by: disposeBag)

        tryAgainObservable
            .subscribe(onNext: { [weak self] in
                self?.setErrorAlert.accept(nil)
                self?.getProducts.accept(())
            })
            .disposed(by: disposeBag)
    }
}
