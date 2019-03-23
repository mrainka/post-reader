//
//  NetworkRepository.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

import Alamofire
import Foundation

struct NetworkRepository<ItemType> where ItemType: Decodable {}

extension NetworkRepository: Repository {

    func query(_ specification: Specification, completion: @escaping (RepositoryQueryResult<ItemType>) -> Void) {
        guard let specification = specification as? NetworkSpecification else {
            completion(.failure)
            return
        }

        Alamofire.request(specification.networkRoute).response {
            guard $0.error == nil, let data = $0.data else {
                completion(.failure)
                return
            }

            DispatchQueue.global(qos: .userInteractive).async {
                guard let item = try? JSONDecoder().decode(ItemType.self, from: data) else {
                    DispatchQueue.main.async { completion(.failure) }
                    return
                }

                DispatchQueue.main.async { completion(.success(item)) }
            }
        }
    }
}
