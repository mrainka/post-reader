//
//  CustomViewContaining.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

protocol CustomViewContaining {

    associatedtype CustomViewType: UIView

    var customView: CustomViewType? { get }
}
