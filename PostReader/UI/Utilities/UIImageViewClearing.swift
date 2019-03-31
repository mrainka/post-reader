//
//  UIImageViewClearing.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import AlamofireImage
import UIKit

extension UIImageView: Clearable {

    func clear() {
        af_cancelImageRequest()
        image = nil
    }
}
