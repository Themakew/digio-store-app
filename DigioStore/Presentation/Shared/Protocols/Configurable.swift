//
//  Configurable.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

protocol Configurable: AnyObject {
    associatedtype Configuration

    func configure(content: Configuration)
}
