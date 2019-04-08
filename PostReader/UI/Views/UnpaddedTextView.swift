//
//  UnpaddedTextView.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 07/04/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

final class UnpaddedTextView: UITextView {

    private func fixBounds() {
        var bounds = self.bounds
        bounds.size.height = sizeThatFits(.init(width: bounds.width, height: .greatestFiniteMagnitude)).height
        self.bounds = bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        fixBounds()
    }
}
