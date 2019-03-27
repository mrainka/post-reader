//
//  CellConfiguring.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

extension UITableViewCell {

    func configureIfPossible(with model: Any) {
        switch (self, model) {
        case let (cell, model) as (TextPostCell, TextPostViewModel):
            cell.configure(with: model)
        default:
            break
        }
    }
}
