//
//  UIImageView+Misc.swift
//  DigioStore
//
//  Created by Ruyther Costa on 2023-10-13.
//

import Kingfisher
import UIKit

extension UIImageView {
    func setImageWithKingfisher(
        _ urlString: String?,
        placeholder: UIImage? = nil,
        onFailureImage: UIImage? = Images.default_image
    ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            image = onFailureImage
            return
        }

        kf.indicatorType = .activity
        kf.setImage(
            with: url,
            placeholder: placeholder,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage,
            ],
            completionHandler: { result in
                switch result {
                case .success(let value):
                    debugPrint("Image downloaded: \(value.image)")
                case .failure:
                    self.image = onFailureImage
                }
            }
        )
    }
}
