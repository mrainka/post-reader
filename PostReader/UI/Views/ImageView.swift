//
//  ImageView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 31/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import AlamofireImage
import SnapKit
import UIKit

final class ImageView: UIImageView {

    private weak var aspectRatioConstraint: Constraint?

    private(set) var model: ImageViewModel?

    private func updateConstraints(aspectRatio: Double) {
        aspectRatioConstraint?.deactivate()

        snp.makeConstraints {
            aspectRatioConstraint = $0.width.equalTo(snp.height).multipliedBy(aspectRatio).constraint
        }
    }
}

extension ImageView: ModelConfigurable {

    func configure(with model: ImageViewModel) {
        self.model = model

        updateConstraints(aspectRatio: model.aspectRatio)
        af_setImage(withURL: model.url)
    }
}
