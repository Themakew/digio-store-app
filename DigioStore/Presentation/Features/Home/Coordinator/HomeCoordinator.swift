//
//  HomeCoordinator.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import UIKit
import XCoordinator

enum HomeRouter: Route {
    case home
    case detailScreen(object: DetailEntity)
}

final class HomeCoordinator: NavigationCoordinator<HomeRouter> {

    // MARK: - Initializer

    init() {
        super.init(initialRoute: .home)
    }

    // MARK: - Override Method

    override func prepareTransition(for route: HomeRouter) -> NavigationTransition {
        switch route {
        case .home:
            let service = ServiceAPICall()
            let serviceAPI = ProductsAPIService(serviceAPI: service)
            let repository = ProductsRepository(productsService: serviceAPI)
            let useCase = ProductsUseCase(productsRepository: repository)
            let viewModel = HomeViewModel(router: weakRouter, productsUseCase: useCase)
            let viewController = HomeViewController(viewModel: viewModel)
            return .push(viewController)
        case let .detailScreen(object):
            return .push(UIViewController())
        }
    }
}
