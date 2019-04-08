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

    private static var fontOfDateLabel: UIFont { return .preferredFont(forTextStyle: .footnote) }

    static var preferredHeightOfDateLabel: CGFloat { return "".preferredHeight(with: fontOfDateLabel) }

    static var spacingOfStackView: CGFloat { return Margin.large }

    static func configure(_ textView: UITextView, with model: TextViewModel<NSAttributedString>) {
        textView.attributedText = model.text
        textView.isHidden = model.isHidden

        textView.layoutIfNeeded()
    }

    static func makeConstraints(of stackView: UIStackView, inset: UIEdgeInsets) {
        stackView.snp.makeConstraints { $0.edges.equalToSuperview().inset(inset) }
    }

    static func preferredHeightOfTextView(
        with model: TextViewModel<NSAttributedString>,
        fittingWidth targetWidth: CGFloat)
            -> CGFloat
    {
        guard !model.isHidden else { return 0 }
        return model.text?.preferredHeight(fittingWidth: targetWidth) ?? 0
    }

    // MARK: - Adding the Subviews

    static func addDateLabel(to stackView: UIStackView) -> UILabel {
        let label = UILabel(frame: .zero)

        label.font = fontOfDateLabel
        label.textAlignment = .right
        label.textColor = .darkGray

        stackView.addArrangedSubview(label)

        return label
    }

    func addStackView(alignment: UIStackView.Alignment = .fill) -> UIStackView {
        let stackView = UIStackView(frame: .zero)

        stackView.alignment = alignment
        stackView.axis = .vertical
        stackView.spacing = type(of: self).spacingOfStackView

        addSubview(stackView)

        return stackView
    }

    static func addTextView(to stackView: UIStackView) -> UITextView {
        let textView = UnpaddedTextView(frame: .zero)

        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero

        stackView.addArrangedSubview(textView)

        return textView
    }
}
