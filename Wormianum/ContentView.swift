//
//  ContentView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/9/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            NavigationList {
                CategoriesView()
            }
            Spacer()
        }
    }
}

struct CategoriesView: View {
    var body: some View {
        AnimationView()
            .destinationInfo("Animation", icon: "figure.run.square.stack")
        ContainersView()
            .destinationInfo("Containers", icon: "shippingbox.fill")
        VisualEffectsView()
            .destinationInfo("Visual Effects", icon: "bubbles.and.sparkles.fill")
    }
}

struct Description: View {

    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .background(Color.green.opacity(0.2))
            .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
