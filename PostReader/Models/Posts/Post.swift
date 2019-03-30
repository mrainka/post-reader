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
        case caption
        case date
        case format
        case photos
        case title
        case type
    }

    let body: String?
    let caption: String?
    let date: Date?
    let format: PostFormat?
    let photo: Photo?
    let title: String?
    let type: PostType?
}

extension Post: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        body = try? container.decode(String.self, forKey: .body)
        caption = try? container.decode(String.self, forKey: .caption)
        date = try? container.decode(Date.self, forKey: .date)
        format = try? container.decode(PostFormat.self, forKey: .format)
        photo = (try? container.decode([Photo].self, forKey: .photos))?.first
        title = try? container.decode(String.self, forKey: .title)
        type = try? container.decode(PostType.self, forKey: .type)
    }
}
