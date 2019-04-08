//
//  PostsTableViewDataSourceAndDelegateModelTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 07/04/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import XCTest

final class PostsTableViewDataSourceAndDelegateModelTests: XCTestCase {

    private var repository: RepositoryMock<Posts>!

    override func setUp() {
        super.setUp()
        repository = .init()
    }

    func testFetchedSupportedPostsShouldBeUsed() {
        repository.onQueried = { $1(.success(.init(nextPage: nil, posts: [.anySupported()]))); return nil }
        let posts = PostsTableViewDataSourceAndDelegateModel(posts: .init(repository))
        posts.fetchFirstPage(blogName: "anyblog")
        expect(posts.posts).toEventuallyNot(beEmpty())
    }

    func testFetchedUnsupportedPostsShouldNotBeUsed() {
        repository.onQueried = { $1(.success(.init(nextPage: nil, posts: [.any()]))); return nil }
        let posts = PostsTableViewDataSourceAndDelegateModel(posts: .init(repository))
        posts.fetchFirstPage(blogName: "anyblog")
        expect(posts.posts).toEventually(beEmpty())
    }
}
