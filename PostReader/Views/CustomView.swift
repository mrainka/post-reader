//
//  CustomView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(#function + " has not been implemented")
    }

    /// If you subclass CustomView directly, your implementation of this method does not need to call `super`.
    func addSubviews() {}

    func configure() {
        addSubviews()
        makeConstraints()
    }

    /// If you subclass CustomView directly, your implementation of this method does not need to call `super`.
    func makeConstraints() {}
}
