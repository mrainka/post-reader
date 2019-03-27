//
//  TextPostViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation

struct TextPostViewModel {

    static let cellReuseID = "TextPostCell"

    let text: NSAttributedString?
    let title: String?

    init(_ post: Post) {
        text = type(of: self).text(with: post)
        title = post.title
    }

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

    private static func text(with post: Post) -> NSAttributedString? {
        guard post.format == .html, let body = post.body else { return nil }
        let encoding = String.Encoding.utf8
        guard let data = html(with: body).data(using: encoding, allowLossyConversion: true) else { return nil }
        return try? .init(
            data: data,
            options: [.characterEncoding: encoding.rawValue, .documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil)
    }
}

extension TextPostViewModel: CellReuseIdentifiable {}
