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

    static func configure(_ textView: UITextView, with text: NSAttributedString?) {
        textView.attributedText = text
        textView.layoutIfNeeded()
    }

    static func makeConstraints(of stackView: UIStackView) {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Adding the Subviews

    static func addDateLabel(to stackView: UIStackView) -> UILabel {
        let label = UILabel(frame: .zero)
        stackView.addArrangedSubview(label)
        return label
    }

    func addStackView() -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.axis = .vertical
        stackView.spacing = 16

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
