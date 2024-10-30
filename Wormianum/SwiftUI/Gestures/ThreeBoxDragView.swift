//
//  ThreeBoxView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/15/24.
//

import SwiftUI

/*
 Demonstrates SwiftUI gestures.

 From: MoveMe - Whacky Labs
 https://whackylabs.com/swift/swiftui/ios/animation/2024/09/12/moveme-swiftui-edition/
*/

struct ThreeBoxDragView: View {

    // swiftlint:disable line_length
    let headerText = """
    Drag views to arbitrary positions.\n\nUses a DragGesture with zero minimumDistance to replicate a Touch Down gesture.
    """
    // swiftlint:enable line_length

    var body: some View {
        VStack {
            Description(headerText)
                .font(.title)
            ZStack {
                ForEach(0..<3) { index in
                    GeometryReader { geometry in
                        SquareView(position: CGPoint(
                            x: geometry.size.width * 0.5,
                            y: geometry.size.height
                            * (CGFloat(index + 1) / 4.0)
                        ))
                    }
                }
            }
        }
    }
}

struct SquareView: View {

    var size = CGSize(width: 100, height: 100)

    @State var position: CGPoint
    @State var isSelected = false

    var body: some View {
        RoundedRectangle(cornerRadius: 25.0, style: .continuous)

            // Scale effect applied before position is supposed
            // to keep the box centered when scaling.
            .scaleEffect(isSelected ? 1.2 : 1.0)
            .animation(.easeOut, value: isSelected)
            .frame(width: size.width, height: size.height)
            .position(CGPoint(
                x: position.x,
                y: position.y)
            )
            .foregroundStyle(isSelected ? .red : .blue)
            .scaleEffect(isSelected ? 1.2 : 1.0)
            .gesture(
                // Use drag gesture with min distance of 0
                // to simulate a on tap begin gesture.
                DragGesture(minimumDistance: 0.0)
                    .onChanged { value in
                        isSelected = true
                        position = value.location
                    }
                    .onEnded { _ in
                        isSelected = false
                    }
            )
    }
}

#Preview {
    ThreeBoxDragView()
}
