//
//  CustomTableViewCell.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import SnapKit
import UIKit

class CustomTableViewCell<CustomViewType: UIView>: UITableViewCell {

    private(set) weak var customView: CustomViewType?

    class var customViewInset: UIEdgeInsets { return .zero }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(notImplementedFunction: #function)
    }

    private func addCustomView() -> CustomViewType {
        let customView = CustomViewType(frame: .zero)
        contentView.addSubview(customView)
        self.customView = customView
        return customView
    }

    func configure() {
        addCustomView().snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(type(of: self).customViewInset).priority(999)
            $0.left.right.top.equalToSuperview().inset(type(of: self).customViewInset)
        }
    }
}

extension CustomTableViewCell: Configurable {}

extension CustomTableViewCell: CustomViewContaining {}
