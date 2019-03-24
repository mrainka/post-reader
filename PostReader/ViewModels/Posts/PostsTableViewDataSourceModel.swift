//
//  PostsTableViewDataSourceModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Foundation
import RxCocoa

struct PostsTableViewDataSourceModel {

    var numberOfPosts: Int { return posts.value.count }

    let posts = BehaviorRelay(value: [PostViewModel]())

    func post(forRowAt indexPath: IndexPath) -> PostViewModel {
        return posts.value[indexPath.row]
    }
}
