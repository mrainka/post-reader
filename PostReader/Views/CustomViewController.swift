//
//  CustomViewController.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import UIKit

class CustomViewController<CustomViewType: UIView>: UIViewController {

    private(set) weak var customView: CustomViewType?

    override func loadView() {
        let customView = CustomViewType(frame: .zero)
        view = customView
        self.customView = customView
    }
}
