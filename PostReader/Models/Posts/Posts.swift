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

            enum Links: String, CodingKey {

                enum Next: String, CodingKey {

                    case queryParameters = "query_params"
                }

                case next
            }

            case links = "_links"
            case posts
        }

        case response
    }

    let nextPage: Page?
    let posts: [Post]

    private static func nextPage(from container: KeyedDecodingContainer<CodingKeys.Response>) -> Page? {
        guard
            let linksContainer = try? container.nestedContainer(
                keyedBy: CodingKeys.Response.Links.self,
                forKey: .links),
            let nextContainer = try? linksContainer.nestedContainer(
                keyedBy: CodingKeys.Response.Links.Next.self,
                forKey: .next)
        else { return nil }

        return try? nextContainer.decode(Page.self, forKey: .queryParameters)
    }
}

extension Posts: Decodable {

    init(from decoder: Decoder) throws {
        let responseContainer = try decoder.container(keyedBy: CodingKeys.self).nestedContainer(
            keyedBy: CodingKeys.Response.self,
            forKey: .response)

        nextPage = type(of: self).nextPage(from: responseContainer)
        posts = (try? responseContainer.decode([Post].self, forKey: .posts)) ?? []
    }
}
