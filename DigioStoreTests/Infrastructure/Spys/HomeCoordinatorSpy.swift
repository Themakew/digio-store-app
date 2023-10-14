//
//  HomeCoordinatorSpy.swift
//  DigioStoreTests
//
//  Created by Ruyther Costa on 2023-10-13.
//

import XCoordinator
@testable import DigioStore

final class HomeCoordinatorSpy: NavigationCoordinator<HomeRouter> {

    // MARK: - Internal Properties

    var currentRoute: HomeRouter = .home

    // MARK: - Initializer

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Override Method

    override func prepareTransition(for route: HomeRouter) -> NavigationTransition {
        currentRoute = route
        return .none()
    }
}

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
