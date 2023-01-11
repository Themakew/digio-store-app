//
//  ErrorEntity.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import RxRelay
import UIKit

struct ErrorEntity {
    let dataSource: GenericErrorEntity
    let tryAgainObserver: PublishRelay<Void>
    let isShown: BehaviorRelay<Bool>
}

struct GenericErrorEntity {
    let messageErrorText: String
    let buttonTitleText: String
    let icon: UIImage
    let backgroudColor: UIColor
}
