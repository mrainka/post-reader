//
//  Comparisons.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader

extension RepositoryQueryResult: Equatable {

    public static func == (lhs: RepositoryQueryResult, rhs: RepositoryQueryResult) -> Bool {
        return String(describing: lhs) == String(describing: rhs)
    }
}
