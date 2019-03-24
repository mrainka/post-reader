//
//  PostsSpecification.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

struct PostsSpecification {

    let networkRoute: NetworkRoute

    init(blogID: String, page: Page?) {
        networkRoute = .posts(blogID: blogID, page: page)
    }
}

extension PostsSpecification: NetworkSpecification {}
