//
//  Photo.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation

struct Photo {

    private enum CodingKeys: String, CodingKey {

        enum OriginalSize: String, CodingKey {

            case height, width
            case url
        }

        case originalSize = "original_size"
    }

    let aspectRatio: Double
    let url: URL?

    private static func aspectRatio(from container: KeyedDecodingContainer<CodingKeys.OriginalSize>) -> Double {
        guard
            let height = try? container.decode(Int.self, forKey: .height),
            height > 0,
            let width = try? container.decode(Int.self, forKey: .width)
        else { return 0 }

        return .init(width) / .init(height)
    }
}

extension Photo: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self).nestedContainer(
            keyedBy: CodingKeys.OriginalSize.self,
            forKey: .originalSize)

        aspectRatio = type(of: self).aspectRatio(from: container)
        url = try? container.decode(URL.self, forKey: .url)
    }
}
