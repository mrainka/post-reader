//
//  PostView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import SnapKit
import UIKit

final class PostView: CustomView {

    private(set) var model: PostViewModel?

    private weak var titleLabel: UILabel!

    override func makeConstraints() {
        titleLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addTitleLabel()
    }

    private func addTitleLabel() {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        addSubview(label)
        titleLabel = label
    }
}

extension PostView: ModelConfigurable {

    func configure(with model: PostViewModel) {
        self.model = model
        titleLabel.text = model.title
    }
}
