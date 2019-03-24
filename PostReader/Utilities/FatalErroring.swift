//
//  FatalErroring.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 24/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

func fatalError(notImplementedFunction: String) -> Never {
    fatalError(notImplementedFunction + " has not been implemented")
}
