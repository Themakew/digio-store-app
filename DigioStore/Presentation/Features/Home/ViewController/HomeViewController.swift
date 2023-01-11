//
//  HomeViewController.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import RxSwift
import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Private Properties

    private let disposeBag = DisposeBag()
    private let viewModel: HomeViewModelProtocol
    private let layout = UICollectionViewFlowLayout().apply {
        $0.scrollDirection = .vertical
        $0.minimumInteritemSpacing = .zero
        $0.minimumLineSpacing = .zero
        $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }

    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).apply {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = true
        $0.backgroundColor = .white
    }

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
        setupView()
        bindRx()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.getProducts.accept(())
    }

    // MARK: - Private Methods

    private func bindRx() {
        viewModel.output.dataSource
            .filterNotNil()
            .map { $0.items }
            .bind(to: collectionView.rx.items) { collectionView, row, dataSource in
                let indexPath = IndexPath(row: row, section: 0)

                switch dataSource {
                case is HomeSpotlightSection:
                    guard let configuration = dataSource as? HomeSpotlightSection else {
                        return UICollectionViewCell()
                    }

                    let cell = collectionView.dequeue(cellClass: SpotlightCell.self, indexPath: indexPath)
                    cell.configure(content: configuration)

                    return cell
                case is HomeCashSection:
                    guard let configuration = dataSource as? HomeCashSection else {
                        return UICollectionViewCell()
                    }

                    let cell = collectionView.dequeue(cellClass: CashCell.self, indexPath: indexPath)
                    cell.configure(content: configuration)

                    return cell
                default:
                    guard let configuration = dataSource as? HomeProductSection else {
                        return UICollectionViewCell()
                    }

                    let cell = collectionView.dequeue(cellClass: ProductsCell.self, indexPath: indexPath)
                    cell.configure(content: configuration)

                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewCode Extension

extension HomeViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func setupAdditionalConfiguration() {
        view.backgroundColor = .white

        collectionView.register(cellClass: SpotlightCell.self)
        collectionView.register(cellClass: CashCell.self)
        collectionView.register(cellClass: ProductsCell.self)
    }
}
