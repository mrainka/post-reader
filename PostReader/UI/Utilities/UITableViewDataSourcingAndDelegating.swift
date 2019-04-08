//
//  UITableViewDataSourcingAndDelegating.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 07/04/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

extension UITableView {

    var dataSourceAndDelegate: (UITableViewDataSource & UITableViewDelegate)? {
        get {
            guard dataSource === delegate else { return nil }
            return dataSource as? UITableViewDataSource & UITableViewDelegate
        }

        set {
            dataSource = newValue
            delegate = newValue
        }
    }
}
