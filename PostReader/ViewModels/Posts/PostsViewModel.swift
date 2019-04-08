//
//  PostsViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import RxCocoa

final class PostsViewModel {

    var canScrollInfinitely: Bool { return tableDataSourceAndDelegate.canScrollInfinitely }

    var isIndicatingActivity: BehaviorRelay<Bool> { return tableDataSourceAndDelegate.isIndicatingActivity }

    var onFinishInfiniteScrollRequested: (() -> Void)? {
        get { return tableDataSourceAndDelegate.onFinishInfiniteScrollRequested }
        set { tableDataSourceAndDelegate.onFinishInfiniteScrollRequested = newValue }
    }

    var onInsertRowsRequested: (([IndexPath]) -> Void)? {
        get { return tableDataSourceAndDelegate.onInsertRowsRequested }
        set { tableDataSourceAndDelegate.onInsertRowsRequested = newValue }
    }

    var onReloadTableRequested: (() -> Void)? {
        get { return tableDataSourceAndDelegate.onReloadTableRequested }
        set { tableDataSourceAndDelegate.onReloadTableRequested = newValue }
    }

    var onResetContentOffsetRequested: (() -> Void)? {
        get { return tableDataSourceAndDelegate.onResetContentOffsetRequested }
        set { tableDataSourceAndDelegate.onResetContentOffsetRequested = newValue }
    }

    var startSearchingWhenAppeared: Bool { return tableDataSourceAndDelegate.posts.isEmpty }

    let tableDataSourceAndDelegate: PostsTableViewDataSourceAndDelegateModel

    init(posts: AnyRepository<Posts> = .init(NetworkRepository())) {
        tableDataSourceAndDelegate = .init(posts: posts)
    }

    func scrolledInfinitely() {
        tableDataSourceAndDelegate.scrolledInfinitely()
    }

    func search(_ text: String?) {
        guard let text = text, !text.isEmpty else { return }
        tableDataSourceAndDelegate.fetchFirstPage(blogName: text)
    }
}
