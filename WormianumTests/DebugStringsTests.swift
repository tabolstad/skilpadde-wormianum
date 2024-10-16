//
//  DebugStringsTests.swift
//  WormianumTests
//
//  Created by Timothy Bolstad on 10/16/24.
//

import Testing
@testable import Wormianum

struct DebugStringsTests {

    @Test func debugDescription() async throws {
        let book = Book(
            title: "The Wormianum",
            author: "Ole Worm",
            pageCount: 42
        )
        #expect(book.debugDescription == "The Wormianum by Ole Worm [42]")
    }
}
