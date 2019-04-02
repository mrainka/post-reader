//
//  NetworkRepositoryAction.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 01/04/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Alamofire
import Dispatch

final class NetworkRepositoryAction {

    weak var dataRequest: DataRequest?
    weak var dispatchWorkItem: DispatchWorkItem?
}

extension NetworkRepositoryAction: RepositoryAction {

    func cancel() {
        dataRequest?.cancel()
        dispatchWorkItem?.cancel()
    }
}
