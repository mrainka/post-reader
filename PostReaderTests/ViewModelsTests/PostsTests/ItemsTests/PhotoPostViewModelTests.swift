//
//  PhotoPostViewModelTests.swift
//  PostReaderTests
//
//  Created by Marcin Rainka @Home on 30/03/2019.
//  Copyright © 2019 Marcin Rainka. All rights reserved.
//

@testable import PostReader
import Nimble
import RxCocoa
import XCTest

final class PhotoPostViewModelTests: XCTestCase {

    func testShouldHaveCaptionWhenPostFormatIsHTML() {
        expect(PhotoPostViewModel(.any(caption: "anycaption", format: .html)).caption).toNot(beNil())
    }

    func testShouldNotHaveCaptionWhenPostFormatIsNotHTML() {
        expect(PhotoPostViewModel(.any(caption: "anycaption")).caption).to(beNil())
    }
}
