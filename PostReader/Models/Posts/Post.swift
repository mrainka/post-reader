//
//  Post.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation

struct Post {

    private enum CodingKeys: String, CodingKey {

        case body
        case date
        case format
        case title
        case type
    }

    let body: String?
    let date: Date?
    let format: PostFormat?
    let title: String?
    let type: PostType?
}

extension Post: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        body = try? container.decode(String.self, forKey: .body)
        date = try? container.decode(Date.self, forKey: .date)
        format = try? container.decode(PostFormat.self, forKey: .format)
        title = try? container.decode(String.self, forKey: .title)
        type = try? container.decode(PostType.self, forKey: .type)
    }
}
