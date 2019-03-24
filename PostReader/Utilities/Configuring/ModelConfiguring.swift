//
//  ModelConfiguring.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

protocol ModelConfigurable {

    associatedtype ModelType

    var model: ModelType? { get }

    func configure(with model: ModelType)
}

extension ModelConfigurable where Self: CustomViewContaining, Self.CustomViewType: ModelConfigurable {

    var model: CustomViewType.ModelType? { return customView?.model }

    func configure(with model: CustomViewType.ModelType) {
        customView?.configure(with: model)
    }
}
