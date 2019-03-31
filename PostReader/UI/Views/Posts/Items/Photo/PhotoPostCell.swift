//
//  PhotoPostCell.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class PhotoPostCell: CustomTableViewCell<PhotoPostView> {

    override static var customViewInset: UIEdgeInsets { return contentInset }

    override func configure() {
        super.configure()
        configureBackgroundColor()
        selectionStyle = type(of: self).selectionStyle
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
}

extension PhotoPostCell: Clearable {}

extension PhotoPostCell: PostCell {}
