//
//  TextPostView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

final class TextPostView: CustomView {

    private(set) var model: TextPostViewModel?

    private weak var stackView: UIStackView!
    private weak var textView: UITextView!
    private weak var titleLabel: UILabel!

    private func configureTextView(with text: NSAttributedString?) {
        textView.attributedText = text
        textView.layoutIfNeeded()
    }

    override func makeConstraints() {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addStackView()
        addTitleLabel()
        addTextView()
    }

    private func addStackView() {
        let stackView = UIStackView(frame: .zero)

        stackView.axis = .vertical
        stackView.spacing = 16

        addSubview(stackView)

        self.stackView = stackView
    }

    private func addTextView() {
        let textView = UITextView(frame: .zero)

        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero

        stackView.addArrangedSubview(textView)

        self.textView = textView
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

        configureTextView(with: model.text)
        titleLabel.text = model.title
    }
}
