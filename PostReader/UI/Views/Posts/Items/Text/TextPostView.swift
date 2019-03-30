//
//  TextPostView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class TextPostView: CustomView {

    private(set) var model: TextPostViewModel?

    // MARK: - Subviews

    private weak var dateLabel: UILabel!
    private weak var textView: UITextView!
    private weak var titleLabel: UILabel!

    private weak var stackView: UIStackView!

    // MARK: -

    override func makeConstraints() {
        type(of: self).makeConstraints(of: stackView)
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        let stackView = addStackView()
        self.stackView = stackView

        addTitleLabel()
        textView = type(of: self).addTextView(to: stackView)
        dateLabel = type(of: self).addDateLabel(to: stackView)
    }

    private func addTitleLabel() {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
        titleLabel = label
    }
}

extension TextPostView: ModelConfigurable {

    func configure(with model: TextPostViewModel) {
        self.model = model

        dateLabel.text = model.date
        type(of: self).configure(textView, with: model.text)
        titleLabel.text = model.title
    }
}

extension TextPostView: PostView {}
