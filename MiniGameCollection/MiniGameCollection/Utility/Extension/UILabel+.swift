//
//  UILabel+.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/24.
//

import UIKit

extension UILabel {

    convenience init(text: String? = nil, color: UIColor = .label, font: UIFont = .preferredFont(forTextStyle: .body), textAlignment: NSTextAlignment = .left) {
        self.init()

        self.text = text
        self.textColor = color
        self.font = font
        self.textAlignment = textAlignment
    }
}
