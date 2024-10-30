//
//  VisualEffectsView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/23/24.
//

import SwiftUI

struct VisualEffectsView: View {

    static let animalList: [String] = [
        "Dog", "Cat", "Bird", "Snake", "Lizard", "Reptile", "Fish", "Amphibian", "Insect", "Mammal"
    ]

    var body: some View {
        NavigationList {
            ScrollTransitionEffectView()
                .destinationInfo("Scroll Transition", icon: "square.grid.3x1.below.line.grid.1x2.fill")
            ListGradientVisualEffectView()
                .destinationInfo("Gradient List", icon: "list.bullet")
        }
    }
}

#Preview {
    VisualEffectsView()
}
