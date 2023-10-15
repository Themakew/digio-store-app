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

    var tryAgainObserver: PublishRelay<Void>?
    var isShown: BehaviorRelay<Bool>?

    func getErrorData(tryAgainObserver: PublishRelay<Void>, isShown: BehaviorRelay<Bool>) -> ErrorEntity {
        let genericErrorEntity = GenericErrorEntity(
            messageErrorText: "messageErrorText",
            buttonTitleText: "buttonTitleText",
            icon: UIImage(),
            backgroudColor: .black
        )

        self.tryAgainObserver = tryAgainObserver
        self.isShown = isShown

        return ErrorEntity(
            dataSource: genericErrorEntity,
            tryAgainObserver: tryAgainObserver,
            isShown: isShown
        )
    }
}
