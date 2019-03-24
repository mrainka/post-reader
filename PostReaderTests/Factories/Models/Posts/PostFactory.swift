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
        date: Date? = nil,
        format: PostFormat? = nil,
        title: String? = nil,
        type: PostType? = nil)
            -> Post
    {
        return .init(body: body, date: date, format: format, title: title, type: type)
    }
}
