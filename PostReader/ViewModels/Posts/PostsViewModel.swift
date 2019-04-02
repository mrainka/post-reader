//
//  PostsViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Dispatch
import RxCocoa

final class PostsViewModel {

    private weak var fetchedPostsProcessing: DispatchWorkItem?

    let isIndicatingActivity = BehaviorRelay(value: false)

    var posts: BehaviorRelay<[PostViewModel]> { return tableDataSource.posts }

    private let repository: AnyRepository<Posts>
    private weak var repositoryAction: RepositoryAction?

    var startSearchingWhenAppeared: Bool { return posts.value.isEmpty }

    let tableDataSource = PostsTableViewDataSourceModel()

    init(posts: AnyRepository<Posts> = .init(NetworkRepository())) {
        repository = posts
    }

    func search(_ text: String?) {
        guard let text = text, !text.isEmpty else { return }
        fetchPosts(blogName: text)
    }

    // MARK: - Fetching the Posts

    private func cancelPostsFetching() {
        fetchedPostsProcessing?.cancel()
        repositoryAction?.cancel()
    }

    private func fetchPosts(blogName: String) {
        cancelPostsFetching()

        isIndicatingActivity.accept(posts.value.isEmpty)

        let specification = PostsSpecification(blogID: blogName + ".tumblr.com", page: .init(limit: 15, offset: 0))

        repositoryAction = repository.query(specification) { [weak self] in
            guard let `self` = self else { return }

            switch $0 {
            case .failure:
                self.isIndicatingActivity.accept(false)
                // TODO: Inform about failure.
            case .success(let posts):
                var postsProcessing: DispatchWorkItem!

                postsProcessing = .init { [weak self] in
                    defer { postsProcessing = nil }

                    let posts = posts.posts.compactMap {
                        postsProcessing.isCancelled ? nil : PostViewModelFactory.post(with: $0)
                    }

                    guard !postsProcessing.isCancelled else { return }

                    DispatchQueue.main.async {
                        guard let `self` = self else { return }
                        self.isIndicatingActivity.accept(false)
                        guard !posts.isEmpty else { return }
                        self.posts.accept(posts)
                    }
                }

                DispatchQueue.global(qos: .userInteractive).async(execute: postsProcessing)

                self.fetchedPostsProcessing = postsProcessing
            }
        }
    }
}
