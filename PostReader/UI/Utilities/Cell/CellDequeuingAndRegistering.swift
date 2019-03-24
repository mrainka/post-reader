//
//  CellDequeuingAndRegistering.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func dequeueReusableCell(with item: CellReuseIdentifiable, for indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: type(of: item).cellReuseID, for: indexPath)
    }

    func register<CellType: UITableViewCell>(_ cellClass: CellType.Type)
        where CellType: ModelConfigurable, CellType.ModelType: CellReuseIdentifiable
    {
        register(cellClass, forCellReuseIdentifier: CellType.ModelType.cellReuseID)
    }
}
