//
//  Clearing.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

protocol Clearable {

    func clear()
}

extension Clearable where Self: CustomViewContaining, Self.CustomViewType: Clearable {

    func clear() {
        customView?.clear()
    }
}
