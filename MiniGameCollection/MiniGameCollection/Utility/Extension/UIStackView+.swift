//
//  UIStackView+.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/23.
//

import UIKit

extension UIStackView {

    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fillEqually) {
        self.init()

        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
}
