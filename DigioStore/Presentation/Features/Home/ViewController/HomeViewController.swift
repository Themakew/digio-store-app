//
//  HomeViewController.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Private Properties

    private let viewModel: HomeViewModelProtocol

    // MARK: - Initializers

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
