//
//  ScrollTransitionEffectView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/30/24.
//

import SwiftUI

struct ScrollTransitionEffectView: View {

    @State private var cardCount: Int = 1

    let animals: [String] = VisualEffectsView.animalList

    var body: some View {
        VStack {
            Description("Paging Horizontal Scroll with scroll transition effect")
                .font(.title)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 30) {
                    ForEach(animals, id: \.self) { animal in
                        AnimalCard(name: animal)
                            .containerRelativeFrame(.horizontal, count: cardCount, spacing: 0)
                            .scrollTransition(axis: .horizontal) { content, phase in
                                content
                                    .rotationEffect(.degrees(phase.value * 10))
                                // isIdentity true if item is fully onscreen.
                                    .offset(y: phase.isIdentity ? 0 : 30)
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .safeAreaPadding(.horizontal, 40)
            Stepper("CardCount", value: $cardCount)
                .padding([.leading, .trailing], 30)
            Spacer()
        }
    }
}

private struct AnimalCard: View, Hashable {

    let name: String

    var body: some View {
        Text(name)
            .frame(maxWidth: .infinity, maxHeight: 300)
            .background(Color.blue.opacity(0.4))
            .cornerRadius(10)
    }
}

#Preview {
    ScrollTransitionEffectView()
}
