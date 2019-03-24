//
//  PostsViewController.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class PostsViewController: CustomViewController<PostsView> {

    private weak var search: UISearchController!

    private func addSearch() {
        let search = UISearchController(searchResultsController: nil)
        navigationItem.searchController = search
        self.search = search
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        addSearch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model?.fetchPosts()
    }
}

extension PostsViewController: ModelConfigurable {}
