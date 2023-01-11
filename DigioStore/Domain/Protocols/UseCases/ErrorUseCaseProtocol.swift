//
//  ErrorUseCaseProtocol.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxRelay

protocol ErrorUseCaseProtocol {
    func getErrorData(
        tryAgainObserver: PublishRelay<Void>,
        isShown: BehaviorRelay<Bool>
    ) -> ErrorEntity
}
