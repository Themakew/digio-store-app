//
//  ErrorUseCase.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxRelay

final class ErrorUseCase: ErrorUseCaseProtocol {

    // MARK: - Internal Methods

    func getErrorData(
        tryAgainObserver: PublishRelay<Void>,
        isShown: BehaviorRelay<Bool>
    ) -> ErrorEntity {
        let object = ErrorEntity(
            dataSource: GenericErrorEntity(
                messageErrorText: "Não foi possível carregar as\n informações solicitadas.",
                buttonTitleText: "Tente Novamente",
                icon: Images.try_again,
                backgroudColor: .white
            ),
            tryAgainObserver: tryAgainObserver,
            isShown: isShown
        )

        return object
    }
}
