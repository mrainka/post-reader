//
//  NetworkSpecification.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 23/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

protocol NetworkSpecification: Specification {

    var networkRoute: NetworkRoute { get }
}
