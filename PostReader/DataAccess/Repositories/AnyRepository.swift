//
//  AnyRepository.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

struct AnyRepository<ItemType> {

    private let onQueried: (Specification, @escaping (RepositoryQueryResult<ItemType>) -> Void) -> RepositoryAction?

    init<RepositoryType: Repository>(_ repository: RepositoryType) where RepositoryType.ItemType == ItemType {
        onQueried = repository.query
    }
}

extension AnyRepository: Repository {

    @discardableResult
    func query(_ specification: Specification, completion: @escaping (RepositoryQueryResult<ItemType>) -> Void)
        -> RepositoryAction?
    {
        return onQueried(specification, completion)
    }
}
