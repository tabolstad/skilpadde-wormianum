//
//  ListGradientVisualEffectView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/30/24.
//

import SwiftUI

struct ListGradientVisualEffectView: View {

    let animals: [String] = VisualEffectsView.animalList

    var body: some View {
        VStack {
            Description("Vertical scroll view with color gradient and rotation visual effect.")
                .font(.title)
            ScrollView(.vertical) {
                VStack(spacing: 22) {
                    ForEach(animals, id: \.self) { animal in
                        ZStack {
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.purple)
                            Text(animal)
                                .foregroundColor(.white)
                        }
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            // Visual Effect lets you change
                            // view properties based on view position and size
                            .visualEffect { content, proxy in
                                content
                                    .rotationEffect(
                                        Angle(degrees: proxy.frame(in: .global).origin.y / 55.0)
                                    )
                                    .hueRotation(
                                        Angle(degrees: proxy.frame(in: .global).origin.y / 10.0)
                                    )
                            }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ListGradientVisualEffectView()
}
