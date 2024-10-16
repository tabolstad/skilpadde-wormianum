//
//  DebugStrings.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/16/24.
//

import Foundation

/*
 Demonstrates CustomDebugStringConvertible & @DebugDescription Macro

 From: digitalbunker
 https://digitalbunker.dev/debug-description-macro-xcode-16
*/

// Adding macro allows you to see the debug description
// in the variable inspector and crash logs.
// Requires Xcode 16
@DebugDescription
struct Book: CustomDebugStringConvertible {
    let title: String
    let author: String
    let pageCount: Int

    var debugDescription: String {
        "\(title) by \(author) [\(pageCount)]"
    }
}
