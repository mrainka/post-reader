//
//  PostsViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import RxCocoa

final class PostsViewModel {

    var posts: BehaviorRelay<[PostViewModel]> { return tableDataSource.posts }

    private let repository: AnyRepository<Posts>

    let tableDataSource = PostsTableViewDataSourceModel()

    init(posts: AnyRepository<Posts> = .init(NetworkRepository())) {
        repository = posts
    }

    func fetchPosts() {
        let page = Page(limit: 10, offset: 0)

        repository.query(PostsSpecification(blogID: "peacecorps.tumblr.com", page: page)) { [weak self] in
            switch $0 {
            case .failure:
                break  // TODO: Inform about failure.
            case .success(let posts):
                DispatchQueue.global(qos: .userInteractive).async {
                    let posts = posts.posts.map(PostViewModel.init)
                    DispatchQueue.main.async { self?.posts.accept(posts) }
                }
            }
        }
    }
}
