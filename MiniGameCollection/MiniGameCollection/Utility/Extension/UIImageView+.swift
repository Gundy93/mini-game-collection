//
//  UIImageView+.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/05/14.
//

import UIKit

extension UIImageView {

    convenience init(image: UIImage?, tintColor: UIColor) {
        self.init()

        self.image = image
        self.tintColor = tintColor
    }
}
