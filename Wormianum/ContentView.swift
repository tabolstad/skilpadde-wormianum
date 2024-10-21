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
            Group(subviews: CategoriesView()) {  destinations in
                ForEach(destinations) { item in
                    NavigationLink(destination: item) {
                        HStack {
                            item.containerValues.icon
                            Text(item.containerValues.title)
                            Spacer()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            Spacer()
        }
    }
}

struct CategoriesView: View {
    var body: some View {
        AnimationView()
            .destinationInfo("Animation")
        ContainersView()
            .destinationInfo("Containers")
    }
}

// Define a view modifier to simplify adding container values
@available(iOS 18.0, *)
struct DestinationInfoModifier: ViewModifier {

    let title: String
    let icon: Image

    func body(content: Content) -> some View {
        content
            .containerValue(\.title, title)
            .containerValue(\.icon, icon)
    }
}

@available(iOS 18.0, *)
extension View {
    public func destinationInfo(_ title: String, icon: Image = Image(systemName: "star")) -> some View {
        modifier(DestinationInfoModifier(title: title, icon: icon))
    }
}

// Create container values to use in the navigation links.
@available(iOS 18.0, *)
extension ContainerValues {
    @Entry var title: String = "Default value"
    @Entry var icon: Image = Image(systemName: "star")
}

#Preview {
    ContentView()
}
