//
//  PostsView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import SnapKit
import UIKit

final class PostsView: CustomView {

    private(set) var model: PostsViewModel?

    private weak var tableView: UITableView!

    override func makeConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    // MARK: - Adding the Subviews

    override func addSubviews() {
        addTableView()
    }

    private func addTableView() {
        let tableView = UITableView(frame: .zero)
        addSubview(tableView)
        self.tableView = tableView
    }
}

extension PostsView: ModelConfigurable {

    func configure(with model: PostsViewModel) {
        self.model = model
    }
}
