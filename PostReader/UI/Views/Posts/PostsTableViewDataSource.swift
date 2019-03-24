//
//  PostsTableViewDataSource.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import UIKit

final class PostsTableViewDataSource: NSObject {

    private(set) var model: PostsTableViewDataSourceModel?
}

extension PostsTableViewDataSource: ModelConfigurable {

    func configure(with model: PostsTableViewDataSourceModel) {
        self.model = model
    }
}

extension PostsTableViewDataSource: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = model?.post(forRowAt: indexPath) else { return .init() }
        let cell = tableView.dequeueReusableCell(with: post, for: indexPath)
        cell.configureIfPossible(with: post)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.numberOfPosts ?? 0
    }
}
