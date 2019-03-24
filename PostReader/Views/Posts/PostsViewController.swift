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

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        addSearch()
    }
}
