//
//  AnimalImageView.swift
//  CustomCollectionLayout
//
//  Created by Орлов Артём on 08/12/2019.
//  Copyright © 2019 Orlov Artem. All rights reserved.
//

import UIKit

final class AnimalImageView: UIImageView {
    init() {
        super.init(frame: .zero)
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 12
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
