//
//  ProductsResponse.swift
//  DigioStore
//
//  Created by Ruyther Costa on 10/01/23.
//

import Foundation

// MARK: - ProductsResponse

struct ProductsResponse: Decodable {
    let spotlight: [Spotlight]?
    let products: [Product]?
    let cash: Cash?
}

// MARK: - Cash

struct Cash: Decodable {
    let title: String?
    let bannerURL: String?
    let description: String?
}

// MARK: - Product

struct Product: Decodable {
    let name: String?
    let imageURL: String?
    let description: String?
}

// MARK: - Spotlight

struct Spotlight: Decodable {
    let name: String?
    let bannerURL: String?
    let description: String?
}
