//
//  SegmentedControl.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 08/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

import UIKit

final class SegmentedControl: UIView {

    private let control = UISegmentedControl()

    init(items: [String]) {
        super.init(frame: .zero)
        for (index, title) in items.enumerated() {
            control.insertSegment(withTitle: title, at: index, animated: false)
        }
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SegmentedControl {
    func configure() {
        addSubview(control)

        control.selectedSegmentIndex = 0
        control.translatesAutoresizingMaskIntoConstraints = false
        control.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        control.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        control.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        control.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
    }
}
