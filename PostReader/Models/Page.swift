//
//  Page.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

private extension KeyedDecodingContainer {

    private func conversionError(
        of inputType: Any.Type,
        to outputType: Any.Type,
        forKey key: KeyedDecodingContainer.Key)
            -> Error
    {
        let description = "Failed to convert \(String(describing: inputType)) to \(String(describing: outputType))."
        return DecodingError.dataCorruptedError(forKey: key, in: self, debugDescription: description)
    }

    func decode(_ type: String.Type, forKey key: KeyedDecodingContainer.Key) throws -> Int {
        let input = try decode(type, forKey: key) as String
        guard let output = Int(input) else { throw conversionError(of: type, to: Int.self, forKey: key) }
        return output
    }
}

struct Page {

    private enum CodingKeys: String, CodingKey {

        case limit, offset
    }

    var isFirst: Bool { return offset == 0 }

    let limit: Int
    let offset: Int
}

extension Page: Decodable {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        limit = try container.decode(String.self, forKey: .limit)
        offset = try container.decode(String.self, forKey: .offset)
    }
}
