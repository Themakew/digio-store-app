//
//  ErrorUseCaseStub.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-13.
//

import Foundation
import RxRelay
@testable import DigioStore

final class ErrorUseCaseStub: ErrorUseCaseProtocol {
    func getErrorData(tryAgainObserver: PublishRelay<Void>, isShown: BehaviorRelay<Bool>) -> ErrorEntity {
        let genericErrorEntity = GenericErrorEntity(
            messageErrorText: "messageErrorText",
            buttonTitleText: "buttonTitleText",
            icon: UIImage(),
            backgroudColor: .black
        )
        let tryAgainObserver = PublishRelay<Void>()
        let isShown = BehaviorRelay<Bool>(value: false)

        return ErrorEntity(
            dataSource: genericErrorEntity,
            tryAgainObserver: tryAgainObserver,
            isShown: isShown
        )
    }
}
