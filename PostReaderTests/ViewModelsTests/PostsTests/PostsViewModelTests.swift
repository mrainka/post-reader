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

    func testFetchedPostsShouldBeUsed() {
        repository.onQueried = { $1(.success(.init(posts: [.any()]))) }
        let posts = PostsViewModel(posts: .init(repository))
        posts.fetchPosts()
        expect(posts.posts.value).toEventuallyNot(beEmpty())
    }
}
