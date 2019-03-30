//
//  PhotoPostView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class PhotoPostView: CustomView {

    private(set) var model: PhotoPostViewModel?

    // MARK: - Subviews

    private weak var captionView: UITextView!
    private weak var dateLabel: UILabel!
    private weak var imageView: UIImageView!

    private weak var stackView: UIStackView!

    // MARK: -

    private func configureImageView(with model: ImageViewModel?) {
        guard let model = model else {
            imageView.clear()
            return
        }

        imageView.configure(with: model)
    }

    override func makeConstraints() {
        type(of: self).makeConstraints(of: stackView)
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        let stackView = addStackView()
        self.stackView = stackView

        addImageView()
        captionView = type(of: self).addTextView(to: stackView)
        dateLabel = type(of: self).addDateLabel(to: stackView)
    }

    private func addImageView() {
        let imageView = UIImageView(frame: .zero)
        stackView.addArrangedSubview(imageView)
        self.imageView = imageView
    }
}

extension PhotoPostView: Clearable {

    func clear() {
        imageView.clear()
    }
}

extension PhotoPostView: ModelConfigurable {

    func configure(with model: PhotoPostViewModel) {
        self.model = model

        type(of: self).configure(captionView, with: model.caption)
        dateLabel.text = model.date
        configureImageView(with: model.image)
    }
}

extension PhotoPostView: PostView {}
