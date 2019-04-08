//
//  PostsTableViewDataSourceAndDelegate.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import UIKit

final class PostsTableViewDataSourceAndDelegate: NSObject {

    private(set) var model: PostsTableViewDataSourceAndDelegateModel?
}

extension PostsTableViewDataSourceAndDelegate: ModelConfigurable {

    func configure(with model: PostsTableViewDataSourceAndDelegateModel) {
        self.model = model
    }
}

extension PostsTableViewDataSourceAndDelegate: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = model?.post(forRowAt: indexPath) else { return .init() }
        let cell = tableView.dequeueReusableCell(with: post, for: indexPath)
        cell.configureIfPossible(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.posts.count ?? 0
    }
}

extension PostsTableViewDataSourceAndDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let post = model?.post(forRowAt: indexPath) else { return 0 }
        return .preferredHeightOfCell(with: post, fittingWidth: tableView.bounds.width)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let post = model?.post(forRowAt: indexPath) else { return 0 }
        return .preferredHeightOfCell(with: post, fittingWidth: tableView.bounds.width)
    }
}
