//
//  Posts.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

struct Posts {

    private enum CodingKeys: String, CodingKey {

        enum Response: String, CodingKey {

            case posts
        }

        case response
    }

    let posts: [Post]

    private static func posts(from container: KeyedDecodingContainer<CodingKeys>) -> [Post] {
        guard let responseContainer = try? container.nestedContainer(
            keyedBy: CodingKeys.Response.self,
            forKey: .response)
        else { return [] }

        return (try? responseContainer.decode([Post].self, forKey: .posts)) ?? []
    }
}

extension Posts: Decodable {

    init(from decoder: Decoder) throws {
        posts = type(of: self).posts(from: try decoder.container(keyedBy: CodingKeys.self))
    }
}
