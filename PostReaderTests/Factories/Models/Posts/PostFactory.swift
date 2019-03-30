//
//  PostFactory.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Foundation

extension Post {

    static func any(
        body: String? = nil,
        caption: String? = nil,
        date: Date? = nil,
        format: PostFormat? = nil,
        photo: Photo? = nil,
        title: String? = nil,
        type: PostType? = nil)
            -> Post
    {
        return .init(body: body, caption: caption, date: date, format: format, photo: photo, title: title, type: type)
    }

    static func anySupported() -> Post {
        return any(type: .text)
    }
}
