//
//  PostView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

protocol PostView: ModelConfigurable where Self: CustomView, ModelType: PostViewModel {}

extension PostView {

    static func configure(_ textView: UITextView, with model: TextViewModel<NSAttributedString>) {
        textView.attributedText = model.text
        textView.isHidden = model.isHidden

        textView.layoutIfNeeded()
    }

    static func makeConstraints(of stackView: UIStackView, inset: UIEdgeInsets) {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(inset) }
    }

    // MARK: - Adding the Subviews

    static func addDateLabel(to stackView: UIStackView) -> UILabel {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        stackView.addArrangedSubview(label)
        return label
    }

    func addStackView(alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.alignment = alignment
        stackView.axis = .vertical
        stackView.spacing = Margin.large

        addSubview(stackView)

        return stackView
    }

    static func addTextView(to stackView: UIStackView) -> UITextView {
        let textView = UITextView(frame: .zero)

        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero

        stackView.addArrangedSubview(textView)

        return textView
    }
}
