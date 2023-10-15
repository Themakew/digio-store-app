//
//  EquatableConformance.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-14.
//

@testable import DigioStore

extension HomeRouter: Equatable {
    public static func == (lhs: HomeRouter, rhs: HomeRouter) -> Bool {
        switch (lhs, rhs) {
        case (.home, .home):
            return true
        case (.dismiss, .dismiss):
            return true
        case let (.detailScreen(lhsObject), .detailScreen(rhsObject)):
            return lhsObject.description == rhsObject.description
        default:
            return false
        }
    }
}
