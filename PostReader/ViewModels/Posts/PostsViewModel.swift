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

    var startSearchingWhenAppeared: Bool { return posts.value.isEmpty }

    let tableDataSource = PostsTableViewDataSourceModel()

    init(posts: AnyRepository<Posts> = .init(NetworkRepository())) {
        repository = posts
    }

    private func fetchPosts(blogName: String) {
        let page = Page(limit: 10, offset: 0)

        repository.query(PostsSpecification(blogID: blogName + ".tumblr.com", page: page)) { [weak self] in
            switch $0 {
            case .failure:
                break  // TODO: Inform about failure.
            case .success(let posts):
                guard !posts.posts.isEmpty else { return }

                DispatchQueue.global(qos: .userInteractive).async {
                    let posts = posts.posts.compactMap { PostViewModelFactory.post(with: $0) }
                    DispatchQueue.main.async { self?.posts.accept(posts) }
                }
            }
        }
    }

    func search(_ text: String?) {
        guard let text = text, !text.isEmpty else { return }
        fetchPosts(blogName: text)
    }
}
