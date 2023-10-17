//
//  DetailViewModelStub.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-16.
//

import RxCocoa
import RxRelay
@testable import DigioStore

final class DetailViewModelStub: DetailViewModelProtocol, DetailViewModelInput, DetailViewModelOutput {
    var dismissScreen = PublishRelay<Void>()
    var titleText: Driver<String> = .just("TitleText")
    var image: Driver<String> = .just("Image")
    var descriptionText: Driver<String> = .just("DescriptionText")
}
