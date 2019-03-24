//
//  ViewLoading.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

protocol ViewLoadable: class {

    var onViewLoaded: (() -> Void)? { get set }
}
