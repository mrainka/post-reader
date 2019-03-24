//
//  RepositoryMock.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader

final class RepositoryMock<ItemType> {

    var onQueried: ((Specification, @escaping (RepositoryQueryResult<ItemType>) -> Void) -> Void)?

    private(set) var queryWasCalled = false
}

extension RepositoryMock: Repository {

    func query(_ specification: Specification, completion: @escaping (RepositoryQueryResult<ItemType>) -> Void) {
        queryWasCalled = true
        onQueried?(specification, completion)
    }
}
