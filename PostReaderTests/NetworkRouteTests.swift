//
//  NetworkRouteTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import XCTest

final class NetworkRouteTests: XCTestCase {

    func testPostsShouldContainAPIKey() {
        expect(NetworkRoute.posts(blogID: "", page: nil).urlRequest?.url?.query).to(contain("api_key"))
    }
}
