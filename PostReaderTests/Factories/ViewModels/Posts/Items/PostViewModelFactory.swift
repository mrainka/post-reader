//
//  PostViewModelFactory.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader

extension PostViewModelFactory {

    static func any() -> PostViewModel {
        return TextPostViewModel(.any())
    }
}
