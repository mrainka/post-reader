//
//  NetworkRepositoryTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import XCTest

final class NetworkRepositoryTests: XCTestCase {

    func testQueryShouldFailImmediatelyWhenSpecificationIsOfWrongType() {
        var result: RepositoryQueryResult<Int>?
        NetworkRepository().query(SpecificationMock()) { result = $0 }
        expect(result).to(equal(.failure))
    }
}
