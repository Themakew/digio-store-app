//
//  HomeDataSource.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

struct HomeDataSource {
    var items: [DataSource]
}

struct HomeSpotlightSection: DataSource {
    let items: [DataSource]
}

struct HomeProductSection: DataSource {
    let items: [DataSource]
}

struct HomeCashSection: DataSource {
    let object: CashEntity
}
