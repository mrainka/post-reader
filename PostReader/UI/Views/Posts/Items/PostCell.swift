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

    func configureBackgroundColor() {
        backgroundColor = .clear
        customView?.backgroundColor = .white
    }
}
