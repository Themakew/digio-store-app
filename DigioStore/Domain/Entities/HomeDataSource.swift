//
//  HomeDataSource.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation
import RxRelay

// MARK: - HomeDataSource

struct HomeDataSource: Equatable {
    static func == (lhs: HomeDataSource, rhs: HomeDataSource) -> Bool {
        return lhs.items.count == rhs.items.count
    }

    var items: [DataSource]
}

// MARK: - HomeSpotlightSection

struct HomeSpotlightSection: DataSource, Equatable {
    static func == (lhs: HomeSpotlightSection, rhs: HomeSpotlightSection) -> Bool {
        return lhs.items == rhs.items && lhs.itemSelectedObserver === rhs.itemSelectedObserver
    }

    let items: [SpotlightEntity]
    let itemSelectedObserver: PublishRelay<IndexPath>
}

// MARK: - HomeProductSection

struct HomeProductSection: DataSource, Equatable {
    static func == (lhs: HomeProductSection, rhs: HomeProductSection) -> Bool {
        return lhs.items == rhs.items && lhs.itemSelectedObserver === rhs.itemSelectedObserver
    }

    let items: [ProductEntity]
    let itemSelectedObserver: PublishRelay<IndexPath>
}

// MARK: - HomeCashSection

struct HomeCashSection: DataSource {
    let object: CashEntity
}
