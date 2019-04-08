//
//  PostsTableViewDataSourceAndDelegateModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Dispatch
import Foundation
import RxCocoa

final class PostsTableViewDataSourceAndDelegateModel {

    private var blogID: String?

    var canScrollInfinitely: Bool { return !posts.isEmpty && nextPage != nil }
    var onFinishInfiniteScrollRequested: (() -> Void)?

    private weak var fetchedPostsProcessing: DispatchWorkItem?

    let isIndicatingActivity = BehaviorRelay(value: false)

    private var nextPage: Page?

    var onInsertRowsRequested: (([IndexPath]) -> Void)?
    var onReloadTableRequested: (() -> Void)?

    var onResetContentOffsetRequested: (() -> Void)?

    private(set) var posts = [PostViewModel]()

    private let repository: AnyRepository<Posts>
    private weak var repositoryAction: RepositoryAction?

    init(posts: AnyRepository<Posts> = .init(NetworkRepository())) {
        repository = posts
    }

    func post(forRowAt indexPath: IndexPath) -> PostViewModel {
        return posts[indexPath.row]
    }

    func scrolledInfinitely() {
        cancelPostsFetching()
        fetchPosts()
    }

    // MARK: - Fetching the Posts

    private func cancelPostsFetching() {
        fetchedPostsProcessing?.cancel()
        repositoryAction?.cancel()
    }

    func fetchFirstPage(blogName: String) {
        cancelPostsFetching()
        onFinishInfiniteScrollRequested?()
        blogID = blogName + ".tumblr.com"
        nextPage = .init(limit: 15, offset: 0)
        fetchPosts()
    }

    private func fetchPosts() {
        guard let blogID = blogID else {
            isIndicatingActivity.accept(false)
            onFinishInfiniteScrollRequested?()
            return
        }

        isIndicatingActivity.accept(posts.isEmpty)

        repositoryAction = repository.query(PostsSpecification(blogID: blogID, page: nextPage)) { [weak self] in
            guard let `self` = self else { return }

            switch $0 {
            case .failure:
                self.isIndicatingActivity.accept(false)
                self.onFinishInfiniteScrollRequested?()
                // TODO: Inform about failure.
            case .success(let response):
                var postsProcessing: DispatchWorkItem!

                postsProcessing = .init { [weak self] in
                    defer { postsProcessing = nil }

                    let posts = response.posts.compactMap {
                        postsProcessing.isCancelled ? nil : PostViewModelFactory.post(with: $0)
                    }

                    guard !postsProcessing.isCancelled else { return }

                    DispatchQueue.main.async {
                        guard let `self` = self else { return }

                        self.isIndicatingActivity.accept(false)

                        if self.nextPage?.isFirst ?? true {
                            if !self.posts.isEmpty {
                                self.onResetContentOffsetRequested?()
                            }

                            self.posts = posts

                            self.onReloadTableRequested?()
                        } else {
                            let previousNumberOfPosts = self.posts.count

                            self.posts += posts

                            let newIndexes = (previousNumberOfPosts...self.posts.count - 1).map {
                                IndexPath(row: $0, section: 0)
                            }

                            self.onInsertRowsRequested?(newIndexes)
                        }

                        self.onFinishInfiniteScrollRequested?()

                        self.nextPage = response.nextPage
                    }
                }

                DispatchQueue.global(qos: .userInteractive).async(execute: postsProcessing)

                self.fetchedPostsProcessing = postsProcessing
            }
        }
    }
}
