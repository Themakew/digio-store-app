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

    private let errorView = ErrorView(translateMask: false).apply {
        $0.backgroundColor = .white
    }

    private let spinnerView = UIView(translateMask: false)
    private let spinnerIndicatorView = UIActivityIndicatorView(translateMask: false).apply {
        $0.startAnimating()
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

        viewModel.input.getProducts.accept(())
    }

    // MARK: - Private Methods

    private func addErrorScreen(isHidden: Bool) {
        if isHidden {
            errorView.removeFromSuperview()
        } else {
            view.addSubview(errorView)

            NSLayoutConstraint.activate([
                errorView.topAnchor.constraint(equalTo: view.topAnchor),
                errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        }
    }

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
                case is TitleEntity:
                    guard let configuration = dataSource as? TitleEntity else {
                        return UICollectionViewCell()
                    }

                    let cell = collectionView.dequeue(cellClass: TitleCell.self, indexPath: indexPath)
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

        collectionView.rx.itemSelected
            .filter { $0.item == 2 }
            .bind(to: viewModel.input.cashItemSelected)
            .disposed(by: disposeBag)

        viewModel.output.setErrorAlert
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] object in
                if let object = object {
                    self?.addErrorScreen(isHidden: false)
                    self?.errorView.configure(content: object)
                } else {
                    self?.addErrorScreen(isHidden: true)
                }
            })
            .disposed(by: disposeBag)

        viewModel.output.isLoading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] isLoading in
                if isLoading {
                    self?.spinnerIndicatorView.startAnimating()
                } else {
                    self?.spinnerIndicatorView.stopAnimating()
                }

                self?.spinnerView.isHidden = isLoading
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ViewCode Extension

extension HomeViewController: ViewCode {
    func buildViewHierarchy() {
        view.addSubview(collectionView)

        spinnerView.addSubview(spinnerIndicatorView)
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

        navigationItem.titleView = spinnerIndicatorView

        collectionView.register(cellClass: SpotlightCell.self)
        collectionView.register(cellClass: CashCell.self)
        collectionView.register(cellClass: ProductsCell.self)
        collectionView.register(cellClass: TitleCell.self)
    }
}

#if DEBUG

// MARK: - HomeViewController Extension To Expose Private Properties

extension HomeViewController {
    func getSpinnerView() -> UIView {
        return spinnerView
    }

    func getSpinnerIndicatorView() -> UIActivityIndicatorView {
        return spinnerIndicatorView
    }

    func getErrorView() -> ErrorView {
        return errorView
    }

    func getCollectionView() -> UICollectionView {
        return collectionView
    }
}

#endif
