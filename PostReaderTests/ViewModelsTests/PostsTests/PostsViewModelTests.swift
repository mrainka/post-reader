//
//  PostsViewModelTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import XCTest

final class PostsViewModelTests: XCTestCase {

    private var repository: RepositoryMock<Posts>!

    override func setUp() {
        super.setUp()
        repository = .init()
    }

    func testShouldFetchPostsWithSearchText() {
        let posts = PostsViewModel(posts: .init(repository))
        posts.search("anytext")
        expect(self.repository.queryWasCalled).to(beTrue())
    }

    func testShouldNotFetchPostsWithoutSearchText() {
        let posts = PostsViewModel(posts: .init(repository))

        posts.search(nil)
        posts.search("")

        expect(self.repository.queryWasCalled).to(beFalse())
    }

    func testShouldNotStartSearchingWhenAppearedWithPosts() {
        repository.onQueried = { $1(.success(.init(nextPage: nil, posts: [.anySupported()]))); return nil }
        let posts = PostsViewModel(posts: .init(repository))
        posts.search("anyblog")
        expect(posts.startSearchingWhenAppeared).toEventually(beFalse())
    }

    func testShouldStartSearchingWhenAppearedWithoutPosts() {
        let posts = PostsViewModel(posts: .init(repository))
        expect(posts.startSearchingWhenAppeared).to(beTrue())
    }
}
