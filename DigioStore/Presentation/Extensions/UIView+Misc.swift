//
//  UIView+Misc.swift
//  DigioStore
//
//  Created by Ruyther Costa on 11/01/23.
//

import UIKit

extension UIView {
    convenience init(translateMask: Bool) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = translateMask
    }
}
