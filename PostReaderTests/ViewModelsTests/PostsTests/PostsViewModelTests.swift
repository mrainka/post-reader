//
//  PostsViewModelTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import RxCocoa
import XCTest

final class PostsViewModelTests: XCTestCase {

    private var repository: RepositoryMock<Posts>!

    override func setUp() {
        super.setUp()
        repository = .init()
    }

    func testFetchedSupportedPostsShouldBeUsed() {
        repository.onQueried = { $1(.success(.init(posts: [.anySupported()]))) }
        let posts = PostsViewModel(posts: .init(repository))
        posts.search("anyblog")
        expect(posts.posts.value).toEventuallyNot(beEmpty())
    }

    func testShouldNotFetchPostsWithoutSearchText() {
        let posts = PostsViewModel(posts: .init(repository))

        posts.search(nil)
        posts.search("")

        expect(self.repository.queryWasCalled).to(beFalse())
    }

    func testShouldNotOverridePostsWhenNoNew() {
        repository.onQueried = { $1(.success(.init(posts: []))) }
        let posts = PostsViewModel(posts: .init(repository))
        posts.posts.accept([PostViewModelFactory.any()])
        posts.search("anyblog")
        expect(posts.posts.value).toEventuallyNot(beEmpty())
    }

    func testShouldNotStartSearchingWhenAppearedWithPosts() {
        let posts = PostsViewModel(posts: .init(repository))
        posts.posts.accept([PostViewModelFactory.any()])
        expect(posts.startSearchingWhenAppeared).to(beFalse())
    }

    func testShouldStartSearchingWhenAppearedWithoutPosts() {
        let posts = PostsViewModel(posts: .init(repository))
        expect(posts.startSearchingWhenAppeared).to(beTrue())
    }
}
