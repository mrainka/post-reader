//
//  UIImageViewConfiguring.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import AlamofireImage
import SnapKit
import UIKit

private extension UIImageView {

    func remakeConstraints(aspectRatio: Double) {
        snp.remakeConstraints { $0.width.equalTo(snp.height).multipliedBy(aspectRatio).priority(999) }
    }
}

extension UIImageView: ModelConfigurable {

    var model: ImageViewModel? { return nil }

    func configure(with model: ImageViewModel) {
        remakeConstraints(aspectRatio: model.aspectRatio)
        af_setImage(withURL: model.url)
    }
}
