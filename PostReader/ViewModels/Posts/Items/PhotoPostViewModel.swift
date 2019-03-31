//
//  PhotoPostViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation

struct PhotoPostViewModel {

    let caption: TextViewModel<NSAttributedString>
    let date: String?
    let image: ImageViewModel?

    static let cellReuseID = "PhotoPostCell"

    private static let dateFormatter = PhotoPostViewModel.dateFormatter()

    init(_ post: Post) {
        caption = type(of: self).text(post.caption, of: post.format)
        date = type(of: self).date(with: post.date, formattedBy: type(of: self).dateFormatter)
        image = ImageViewModel(post.photo)
    }
}

extension PhotoPostViewModel: PostViewModel {}
