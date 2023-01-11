//
//  HomeDataSource.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation
import RxRelay

struct HomeDataSource {
    var items: [DataSource]
}

struct HomeSpotlightSection: DataSource {
    let items: [SpotlightEntity]
    let itemSelectedObserver: PublishRelay<IndexPath>
}

struct HomeProductSection: DataSource {
    let items: [ProductEntity]
    let itemSelectedObserver: PublishRelay<IndexPath>
}

struct HomeCashSection: DataSource {
    let object: CashEntity
}
