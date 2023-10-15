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
