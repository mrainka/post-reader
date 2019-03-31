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

    private func configureTitleLabel(with model: TextViewModel<String>) {
        titleLabel.isHidden = model.isHidden
        titleLabel.text = model.text
    }

    override func makeConstraints() {
        type(of: self).makeConstraints(
            of: stackView,
            inset: .init(top: Margin.default, left: Margin.default, bottom: Margin.default, right: Margin.default))
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

        label.font = .preferredFont(forTextStyle: .title1)
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
        configureTitleLabel(with: model.title)
    }
}

extension TextPostView: PostView {}
