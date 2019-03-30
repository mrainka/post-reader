//
//  ImageViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation

struct ImageViewModel {

    let aspectRatio: Double
    let url: URL

    init?(_ photo: Photo?) {
        guard let photo = photo, let url = photo.url else { return nil }

        aspectRatio = photo.aspectRatio
        self.url = url
    }
}
