//
//  ProductsEntity.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation

// MARK: - ProductsEntity

struct ProductsEntity {
    let spotlight: [SpotlightEntity]?
    let products: [ProductEntity]?
    let cash: CashEntity?
}

// MARK: - Cash

struct CashEntity: DataSource {
    let title: String?
    let bannerURL: String?
    let description: String?
}

// MARK: - Product

struct ProductEntity: DataSource {
    let name: String?
    let imageURL: String?
    let description: String?
}

// MARK: - Spotlight

struct SpotlightEntity: DataSource {
    let name: String?
    let bannerURL: String?
    let description: String?
}
