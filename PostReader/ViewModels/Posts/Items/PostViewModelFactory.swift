//
//  PostViewModelFactory.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

struct PostViewModelFactory {

    static func post(with post: Post) -> PostViewModel? {
        guard let type = post.type else { return nil }

        switch type {
        case .photo:
            return PhotoPostViewModel(post)
        case .text:
            return TextPostViewModel(post)
        }
    }
}
