//
//  AnimalsCollectionCell.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 03/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

import UIKit

final class AnimalsCollectionCell: UICollectionViewCell {

    static let identifier = "animalsCell"

    private lazy var imageView = AnimalImageView()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    private enum Metrics {
        static let leftRightOffset: CGFloat = 4
        static let bottomOffset: CGFloat = 10
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.leftRightOffset).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.leftRightOffset).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.bottomOffset).isActive = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -Metrics.bottomOffset).isActive = true

    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var imageBounds: CGRect {
        imageView.bounds
    }

    func set(model: AnimalModel) {
        imageView.image = model.image
        nameLabel.text = model.name
    }
}
