//
//  TextPostCell.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class TextPostCell: CustomTableViewCell<TextPostView> {

    override static var customViewInset: UIEdgeInsets { return contentInset }

    override func configure() {
        super.configure()
        configureBackgroundColor()
        selectionStyle = type(of: self).selectionStyle
    }
}

extension TextPostCell: PostCell {}
