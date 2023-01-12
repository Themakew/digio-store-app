//
//  HomeDataSource.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation
import RxRelay

// MARK: - HomeDataSource

struct HomeDataSource {
    var items: [DataSource]
}

// MARK: - HomeSpotlightSection

struct HomeSpotlightSection: DataSource {
    let items: [SpotlightEntity]
    let itemSelectedObserver: PublishRelay<IndexPath>
}

// MARK: - HomeProductSection

struct HomeProductSection: DataSource {
    let items: [ProductEntity]
    let itemSelectedObserver: PublishRelay<IndexPath>
}

// MARK: - HomeCashSection

struct HomeCashSection: DataSource {
    let object: CashEntity
}
