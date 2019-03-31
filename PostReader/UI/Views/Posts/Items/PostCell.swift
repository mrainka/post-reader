//
//  PostCell.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 31/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

protocol PostCell: CustomViewContaining, ModelConfigurable where Self: UITableViewCell, ModelType: PostViewModel {}

extension PostCell {

    static var contentInset: UIEdgeInsets {
        return .init(top: 0, left: Margin.default, bottom: Margin.default, right: Margin.default)
    }

    static var selectionStyle: SelectionStyle { return .none }

    func roundCorners() {
        guard let customView = customView else { return }

        customView.clipsToBounds = true
        customView.layer.cornerRadius = 6
    }

    // MARK: - Configuring

    func configureBackgroundColor() {
        backgroundColor = .clear
        customView?.backgroundColor = .white
    }

    func configureBorder() {
        guard let customView = customView else { return }

        customView.layer.borderColor = UIColor.white.cgColor
        customView.layer.borderWidth = 1 / UIScreen.main.scale
    }
}
