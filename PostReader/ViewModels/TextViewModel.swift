//
//  TextViewModel.swift
//  PostReader
//
//  Created by Marcin Rainka @Home on 31/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

struct TextViewModel<TextType> {

    let isHidden: Bool
    let text: TextType?

    init(_ text: TextType?) {
        isHidden = text == nil
        self.text = text
    }
}
