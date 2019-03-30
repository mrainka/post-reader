//
//  PhotoPostCell.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

final class PhotoPostCell: CustomTableViewCell<PhotoPostView> {

    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
}

extension PhotoPostCell: Clearable {}

extension PhotoPostCell: ModelConfigurable {}
