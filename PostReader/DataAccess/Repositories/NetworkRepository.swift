//
//  NetworkRepository.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Alamofire
import Dispatch
import Foundation

struct NetworkRepository<ItemType> where ItemType: Decodable {}

extension NetworkRepository: Repository {

    @discardableResult
    func query(_ specification: Specification, completion: @escaping (RepositoryQueryResult<ItemType>) -> Void)
        -> RepositoryAction?
    {
        var action = nil as NetworkRepositoryAction?

        guard let specification = specification as? NetworkSpecification else {
            completion(.failure)
            return action
        }

        action = .init()

        action?.dataRequest = Alamofire.request(specification.networkRoute).response {
            let error = $0.error

            guard error == nil, let data = $0.data else {
                action = nil

                if (error as NSError?)?.code != NSURLErrorCancelled {
                    completion(.failure)
                }

                return
            }

            var dataDecoding: DispatchWorkItem!

            dataDecoding = .init {
                defer {
                    DispatchQueue.main.async { action = nil }
                    dataDecoding = nil
                }

                let jsonDecoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'GMT'"
                jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)

                let item = try? jsonDecoder.decode(ItemType.self, from: data)

                guard !dataDecoding.isCancelled else { return }

                if let item = item {
                    DispatchQueue.main.async { completion(.success(item)) }
                } else {
                    DispatchQueue.main.async { completion(.failure) }
                }
            }

            DispatchQueue.global(qos: .userInteractive).async(execute: dataDecoding)

            action?.dispatchWorkItem = dataDecoding
        }

        return action
    }
}
