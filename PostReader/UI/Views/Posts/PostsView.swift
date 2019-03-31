//
//  PostsView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import RxCocoa
import RxSwift
import SnapKit
import UIKit

final class PostsView: CustomView {

    private let disposeBag = DisposeBag()

    private(set) var model: PostsViewModel?

    // MARK: - Subviews

    private weak var activityIndicatorView: UIActivityIndicatorView!

    private weak var tableView: UITableView!
    private let tableViewDataSource = PostsTableViewDataSource()

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
        tableView.dataSource = tableViewDataSource
        tableView.separatorStyle = .none

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

        tableViewDataSource.configure(with: model.tableDataSource)
        model.posts.subscribe(onNext: { [unowned self] _ in self.tableView.reloadData() }).disposed(by: disposeBag)
    }
}
