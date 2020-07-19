//
//  FeedVideoTests.swift
//  Powder TestTests
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import XCTest
@testable import Powder_Test

class FeedVideoTests: XCTestCase {

    func testExample() throws {
        let video = JSONReader.buildModelFromFile(fileName: "video", type: FeedVideo.self)
        XCTAssert(video?.game == "Valorant")
    }
}
