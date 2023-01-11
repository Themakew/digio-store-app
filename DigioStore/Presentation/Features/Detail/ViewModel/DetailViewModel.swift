//
//  DetailViewModel.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxCocoa
import RxRelay
import RxSwift
import UIKit
import XCoordinator

protocol DetailViewModelProtocol {
    var input: DetailViewModelInput { get }
    var output: DetailViewModelOutput { get }
}

protocol DetailViewModelInput {
    var getData: PublishRelay<Void> { get }
    var dismissScreen: PublishRelay<Void> { get }
}

protocol DetailViewModelOutput {
    var titleText: Driver<String> { get }
    var image: PublishRelay<String> { get }
    var descriptiontext: Driver<String> { get }
}

extension DetailViewModelProtocol where Self: DetailViewModelInput & DetailViewModelOutput {
    var input: DetailViewModelInput { return self }
    var output: DetailViewModelOutput { return self }
}

final class DetailViewModel: DetailViewModelProtocol, DetailViewModelInput, DetailViewModelOutput {

    // MARK: - Internal Properties

    // Inputs
    let getData = PublishRelay<Void>()
    let dismissScreen = PublishRelay<Void>()

    // Outputs
    lazy var titleText: Driver<String> = .just(detailObject.title ?? "")
    lazy var descriptiontext: Driver<String> = .just(detailObject.description ?? "")
    let image = PublishRelay<String>()

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let detailObject: DetailEntity

    // MARK: - Private Properties

    private let router: WeakRouter<HomeRouter>

    // MARK: - Initializer

    init(router: WeakRouter<HomeRouter>, detailObject: DetailEntity) {
        self.router = router
        self.detailObject = detailObject

        bindRx()
    }

    // MARK: - Private Methods

    private func bindRx() {
        getData
            .withUnretained(self)
            .subscribe(onNext: { this, _ in
                this.image.accept(this.detailObject.imageURL ?? "")
            })
            .disposed(by: disposeBag)

        dismissScreen
            .subscribe(onNext: { [weak self] in
                self?.router.trigger(.dismiss)
            })
            .disposed(by: disposeBag)
    }
}
