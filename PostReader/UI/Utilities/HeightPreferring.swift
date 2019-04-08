//
//  HeightPreferring.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 07/04/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {

    static func preferredHeightOfCell(with post: PostViewModel, fittingWidth targetWidth: CGFloat) -> CGFloat {
        switch post {
        case let photoPost as PhotoPostViewModel:
            return PhotoPostCell.preferredHeight(with: photoPost, fittingWidth: targetWidth)
        case let textPost as TextPostViewModel:
            return TextPostCell.preferredHeight(with: textPost, fittingWidth: targetWidth)
        default:
            return 0
        }
    }
}

protocol HeightPreferable {

    associatedtype HeightPreferringModelType

    static func preferredHeight(with model: HeightPreferringModelType, fittingWidth targetWidth: CGFloat) -> CGFloat
}

extension NSAttributedString {

    func preferredHeight(fittingWidth targetWidth: CGFloat) -> CGFloat {
        let size = CGSize(width: targetWidth, height: .greatestFiniteMagnitude)
        return ceil(boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).height)
    }
}

extension String {

    func preferredHeight(with font: UIFont, fittingWidth targetWidth: CGFloat = .greatestFiniteMagnitude) -> CGFloat {
        let boundingRect = self.boundingRect(
            with: .init(width: targetWidth, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil)
        return ceil(boundingRect.height)
    }
}
