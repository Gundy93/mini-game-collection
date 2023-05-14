//
//  RockSissorsPaperCollectionViewCell.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/05/08.
//

import UIKit

final class RockSissorsPaperCollectionViewCell: UICollectionViewCell {

    static let identifiet: String = String(describing: RockSissorsPaperCollectionViewCell.self)

    private let handShapeLabel = UILabel(font: .preferredFont(forTextStyle: .largeTitle),
                                         textAlignment: .center)

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureViewHierarchy()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with handShape: String) {
        handShapeLabel.backgroundColor = .systemCyan
        handShapeLabel.layer.cornerRadius = 20
        handShapeLabel.layer.masksToBounds = true
        configureLabel(with: handShape)
    }

    private func configureViewHierarchy() {
        addSubview(handShapeLabel)
        handShapeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            handShapeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            handShapeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            handShapeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            handShapeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }

    private func configureLabel(with handShape: String) {
        handShapeLabel.text = handShape
    }
}
