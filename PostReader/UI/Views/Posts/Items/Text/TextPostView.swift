//
//  TextPostView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class TextPostView: CustomView {

    private static let fontOfTitleLabel = UIFont.preferredFont(forTextStyle: .title1)

    private static let inset = Margin.default

    private(set) var model: TextPostViewModel?

    private static let preferredHeightOfDateLabel = TextPostView.preferredHeightOfDateLabel

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
        let inset = type(of: self).inset
        type(of: self).makeConstraints(
            of: stackView,
            inset: .init(top: inset, left: inset, bottom: inset, right: inset))
    }

    private static func preferredHeightOfTextView(
        with model: TextViewModel<String>,
        font: UIFont,
        fittingWidth targetWidth: CGFloat)
            -> CGFloat
    {
        guard !model.isHidden else { return 0 }
        return model.text?.preferredHeight(with: font, fittingWidth: targetWidth) ?? 0
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

        label.font = type(of: self).fontOfTitleLabel
        label.numberOfLines = 0

        stackView.addArrangedSubview(label)

        titleLabel = label
    }
}

extension TextPostView: HeightPreferable {

    static func preferredHeight(with model: TextPostViewModel, fittingWidth targetWidth: CGFloat) -> CGFloat {
        let numberOfViews = 1 + (model.text.isHidden ? 0 : 1) + (model.title.isHidden ? 0 : 1)
        let targetWidth = targetWidth - inset * 2
        return preferredHeightOfDateLabel
            + preferredHeightOfTextView(with: model.text, fittingWidth: targetWidth)
            + preferredHeightOfTextView(with: model.title, font: fontOfTitleLabel, fittingWidth: targetWidth)
            + spacingOfStackView * .init(numberOfViews - 1)
            + inset * 2
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
