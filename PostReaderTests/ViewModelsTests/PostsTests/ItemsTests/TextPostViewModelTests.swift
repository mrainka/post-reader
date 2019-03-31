//
//  TextPostViewModelTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 27/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import RxCocoa
import XCTest

final class TextPostViewModelTests: XCTestCase {

    func testShouldHaveTextWhenPostFormatIsHTML() {
        expect(TextPostViewModel(.any(body: "anybody", format: .html)).text.text).toNot(beNil())
    }

    func testShouldNotHaveTextWhenPostFormatIsNotHTML() {
        expect(TextPostViewModel(.any(body: "anybody")).text.text).to(beNil())
    }
}
