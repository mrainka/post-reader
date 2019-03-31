//
//  PostsViewController.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class PostsViewController: CustomViewController<PostsView>, UISearchBarDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    private weak var search: UISearchController!

    private func addSearch() {
        let search = UISearchController(searchResultsController: nil)

        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.delegate = self

        navigationItem.searchController = search

        self.search = search
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        model?.search(searchBar.text)
    }

    // MARK: - Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if model?.startSearchingWhenAppeared ?? false {
            search.searchBar.becomeFirstResponder()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        addSearch()
    }
}

extension PostsViewController: ModelConfigurable {}
