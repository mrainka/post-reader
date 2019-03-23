//
//  AnyRepositoryTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import XCTest

final class AnyRepositoryTests: XCTestCase {

    func testShouldCallQueryOfGivenRepository() {
        let repository = RepositoryMock<Any>()
        AnyRepository(repository).query(SpecificationMock()) { _ in }
        expect(repository.queryWasCalled).to(beTrue())
    }
}
