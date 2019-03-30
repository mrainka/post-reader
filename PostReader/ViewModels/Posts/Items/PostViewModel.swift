//
//  PostViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation

private extension NSAttributedString {

    var trimmed: NSAttributedString {
        let invertedWhitespacesAndNewlines = CharacterSet.whitespacesAndNewlines.inverted

        let startRange = string.rangeOfCharacter(from: invertedWhitespacesAndNewlines)
        let endRange = string.rangeOfCharacter(from: invertedWhitespacesAndNewlines, options: .backwards)

        guard let startLocation = startRange?.upperBound, let endLocation = endRange?.lowerBound else {
            return .init(string: string)
        }

        let location = string.distance(from: string.startIndex, to: startLocation) - 1
        let length = string.distance(from: startLocation, to: endLocation) + 2

        return attributedSubstring(from: .init(location: location, length: length))
    }
}

protocol PostViewModel: CellReuseIdentifiable {

    var date: String? { get }
}

extension PostViewModel {

    private static func html(with body: String) -> String {
        return """
            <html>
                <head>
                    <style>
                        a { text-decoration: none }
                        body { font: -apple-system-body }
                    </style>
                </head>

                <body>
                    \(body)
                </body>
            </html>
            """
    }

    static func parsed(_ text: String?, of format: PostFormat?) -> NSAttributedString? {
        guard format == .html, let text = text else { return nil }
        let encoding = String.Encoding.utf8
        guard let data = html(with: text).data(using: encoding, allowLossyConversion: true) else { return nil }
        return (try? NSAttributedString(
            data: data,
            options: [.characterEncoding: encoding.rawValue, .documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil))?.trimmed
    }

    // MARK: - Formatting a Date

    static func date(with date: Date?, formattedBy formatter: DateFormatter) -> String? {
        guard let date = date else { return nil }
        return formatter.string(from: date)
    }

    static func dateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
}
