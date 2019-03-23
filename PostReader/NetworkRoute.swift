//
//  NetworkRoute.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Alamofire

enum NetworkRoute {

    case posts(blogID: String, page: Page?)

    private var parameters: Parameters {
        var parameters = ["api_key": "L97X7jhzeYxtzGe79lvcUeU70OX5RVA3n0ijaILbNF2KSBwWKA"] as Parameters

        switch self {
        case .posts(_, let page):
            guard let page = page else { break }
            parameters.merge(["limit": page.limit, "offset": page.offset]) { $1 }
        }

        return parameters
    }

    private var path: String {
        switch self {
        case .posts(let blogID, _):
            return "/blog/\(blogID)/posts"
        }
    }
}

extension NetworkRoute: URLRequestConvertible {

    func asURLRequest() throws -> URLRequest {
        let request = try URLRequest(url: "https://api.tumblr.com/v2".asURL().appendingPathComponent(path))
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
