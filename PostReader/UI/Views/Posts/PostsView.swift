//
//  PostsView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import SnapKit
import UIKit
import UIScrollView_InfiniteScroll

final class PostsView: CustomView {

    private let disposeBag = DisposeBag()

    private(set) var model: PostsViewModel?

    // MARK: - Subviews

    private weak var activityIndicatorView: UIActivityIndicatorView!

    private weak var tableView: UITableView!
    private let tableViewDataSourceAndDelegate = PostsTableViewDataSourceAndDelegate()

    // MARK: -

    override func makeConstraints() {
        activityIndicatorView.snp.makeConstraints { $0.center.equalToSuperview() }
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addTableView()
        addActivityIndicatorView()
    }

    private func addActivityIndicatorView() {
        let activityIndicatorView = UIActivityIndicatorView(frame: .zero)
        activityIndicatorView.style = .whiteLarge
        addSubview(activityIndicatorView)
        self.activityIndicatorView = activityIndicatorView
    }

    private func addTableView() {
        let tableView = UITableView(frame: .zero)

        tableView.backgroundColor = .sherpaBlue
        tableView.contentInset = .init(top: Margin.default, left: 0, bottom: 0, right: 0)
        tableView.dataSourceAndDelegate = tableViewDataSourceAndDelegate
        tableView.separatorStyle = .none

        tableView.addInfiniteScroll { [weak self] _ in self?.model?.scrolledInfinitely() }
        tableView.infiniteScrollIndicatorView = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 24, height: 24))
        tableView.setShouldShowInfiniteScrollHandler { [weak self] _ in self?.model?.canScrollInfinitely ?? false }

        tableView.register(PhotoPostCell.self)
        tableView.register(TextPostCell.self)

        addSubview(tableView)

        self.tableView = tableView
    }
}

extension PostsView: ModelConfigurable {

    func configure(with model: PostsViewModel) {
        self.model = model

        model.isIndicatingActivity.bind(to: activityIndicatorView.rx.isAnimating).disposed(by: disposeBag)

        model.onFinishInfiniteScrollRequested = { [weak self] in self?.tableView.finishInfiniteScroll() }

        model.onResetContentOffsetRequested = { [weak self] in
            self?.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: false)
        }

        tableViewDataSourceAndDelegate.configure(with: model.tableDataSourceAndDelegate)
        model.onInsertRowsRequested = { [weak self] in self?.tableView.insertRows(at: $0, with: .fade) }
        model.onReloadTableRequested = { [weak self] in self?.tableView.reloadData() }
    }
}
