//
//  PostViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

struct PostViewModel {

    let title: String?

    init(_ post: Post) {
        title = post.title
    }
}
