//
//  TextPostViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation

struct TextPostViewModel {

    static let cellReuseID = "TextPostCell"

    let date: String?
    let text: NSAttributedString?
    let title: String?

    private static let dateFormatter = TextPostViewModel.dateFormatter()

    init(_ post: Post) {
        date = type(of: self).date(with: post.date, formattedBy: type(of: self).dateFormatter)
        text = type(of: self).parsed(post.body, of: post.format)
        title = post.title
    }
}

extension TextPostViewModel: PostViewModel {}
