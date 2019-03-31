//
//  PostsViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import RxCocoa

final class PostsViewModel {

    let isIndicatingActivity = BehaviorRelay(value: false)

    var posts: BehaviorRelay<[PostViewModel]> { return tableDataSource.posts }

    private let repository: AnyRepository<Posts>

    var startSearchingWhenAppeared: Bool { return posts.value.isEmpty }

    let tableDataSource = PostsTableViewDataSourceModel()

    init(posts: AnyRepository<Posts> = .init(NetworkRepository())) {
        repository = posts
    }

    private func fetchPosts(blogName: String) {
        isIndicatingActivity.accept(posts.value.isEmpty)

        let page = Page(limit: 10, offset: 0)

        repository.query(PostsSpecification(blogID: blogName + ".tumblr.com", page: page)) { [weak self] in
            switch $0 {
            case .failure:
                self?.isIndicatingActivity.accept(false)
                // TODO: Inform about failure.
            case .success(let posts):
                DispatchQueue.global(qos: .userInteractive).async {
                    let posts = posts.posts.compactMap { PostViewModelFactory.post(with: $0) }

                    DispatchQueue.main.async {
                        guard let `self` = self else { return }
                        self.isIndicatingActivity.accept(false)
                        guard !posts.isEmpty else { return }
                        self.posts.accept(posts)
                    }
                }
            }
        }
    }

    func search(_ text: String?) {
        guard let text = text, !text.isEmpty else { return }
        fetchPosts(blogName: text)
    }
}
