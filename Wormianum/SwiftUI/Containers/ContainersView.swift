//
//  ContainersView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/21/24.
//

import SwiftUI

/*
 Demonstrates usage of SwiftUI container views using
 view composition APi introduced in iOS 18

 References:
 WWDC24 - Demystify SwiftUI container
 https://developer.apple.com/videos/play/wwdc2024/10146/
 Paul Hudson - Containers
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-and-style-subviews-that-come-from-a-different-view
 Paul Hudson - Custom Layout
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-custom-layout-using-the-layout-protocol
*/

struct Song: Hashable {
    enum SongType: String {
        case left
        case right
    }

    let title: String
    let type: SongType
}

struct ContainersView: View {

    static var Songs4: [Song] = ["Hello", "World", "SwiftUI", "Is"].map {
        Song(title: $0, type: .left)
    }
    static var Songs5: [Song] = ["Hello", "World", "SwiftUI", "Is", "Awesome"].map {
        Song(title: $0, type: .right)
    }

    var body: some View {
        DisplayBoard {
            Section(
                content: {
                    ForEach(ContainersView.Songs4, id: \.self) { song in
                        Text(song.title)
                    }
                },
                header: {
                    Text("Top Views")
                }
            )
            Section(
                content: {
                    ForEach(ContainersView.Songs5, id: \.self) { song in
                        Text(song.title)
                            .cardIsSelected(true)
                    }
                },
                header: {
                    Text("Bottom Views")
                }
            )
        }
    }
}

struct DisplayBoardLayout: Layout {

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) -> CGSize {
            // accept the full proposed space, replacing any nil values with a sensible default
            proposal.replacingUnspecifiedDimensions()
        }

        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout Void) {
            // calculate the radius of our bounds
            let radius = min(bounds.size.width, bounds.size.height) / 2

            // figure out the angle between each subview on our circle
            let angle = Angle.degrees(360 / Double(subviews.count)).radians

            for (index, subview) in subviews.enumerated() {
                // ask this view for its ideal size
                let viewSize = subview.sizeThatFits(.unspecified)

                // calculate the X and Y position so this view lies inside our circle's edge
                let xPos = cos(angle * Double(index) - .pi / 2) * (radius - viewSize.width / 2)
                let yPos = sin(angle * Double(index) - .pi / 2) * (radius - viewSize.height / 2)

                // position this view relative to our centre, using its natural size ("unspecified")
                let point = CGPoint(x: bounds.midX + xPos, y: bounds.midY + yPos)
                subview.place(at: point, anchor: .center, proposal: .unspecified)
            }
        }
}

struct DisplayBoard<Content: View>: View {

    @ViewBuilder var content: Content

    var body: some View {
        VStack(spacing: 10) {
            ForEach(sections: content) { section in
                VStack(spacing: 10) {
                    if !section.header.isEmpty {
                        section.header
                            .font(.title2)
                            .bold()
                    }
                    DisplayBoardSection {
                        section.content
                    }
                    .background(Color.black.opacity(0.1))
                    .cornerRadius(10)
                    .padding(10)
                }
            }
        }
    }
}

struct DisplayBoardSection<Content: View>: View {

    @ViewBuilder var content: Content

    var body: some View {
        DisplayBoardLayout {
            // Group gives you a collection of subviews.
            // use this to get the count.
            Group(subviews: content) { subviews in
                // ForEach iterates each subview.
                ForEach(subviews: subviews) { subview in
                    // Container values allow a subview to pass
                    // information to their direct container view.
                    let values = subview.containerValues

                    CardView(
                        scale: scaleForCount(subviews.count),
                        isSelected: values.cardIsSelected) {
                        subview
                    }
                }
            }
        }
    }

    func scaleForCount(_ count: Int) -> CardScale {
        count > 4 ? .small : .large
    }
}

enum CardScale {
    case small, large
}

struct CardView<Content: View>: View {

    var scale: CardScale
    @State var isSelected: Bool = false
    @ViewBuilder var content: Content

    var body: some View {
        HStack(spacing: 10) {
            if isSelected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
            content
                .frame(height: scaledHeight)
                .padding()
                .background(Color.green.opacity(0.5))
                .cornerRadius(10)
        }
    }

    var scaledHeight: CGFloat {
        switch scale {
        case .small:
            10
        case .large:
            100
        }
    }
}

private extension ContainerValues {
    @Entry var cardIsSelected: Bool = false
}

private extension View {
    func cardIsSelected(_ isSelected: Bool) -> some View {
        containerValue(\.cardIsSelected, isSelected)
    }
}

#Preview {
    DisplayBoard {
        Section(
            content: {
                ForEach(ContainersView.Songs4, id: \.self) { song in
                    Text(song.title)
                }
            },
            header: {
                Text("Top Views")
            }
        )
        Section(
            content: {
                ForEach(ContainersView.Songs5, id: \.self) { song in
                    Text(song.title)
                        .cardIsSelected(true)
                }
            },
            header: {
                Text("Bottom Views")
            }
        )
    }
}
