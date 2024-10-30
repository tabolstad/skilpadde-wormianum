//
//  Navigation.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/23/24.
//

import SwiftUI

@available(iOS 18.0, *)
struct NavigationList<Content: View>: View {

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        List {
            Group(subviews: content) {  destinations in
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
        }
    }
}

// Define a view modifier to simplify adding container values
@available(iOS 18.0, *)
struct DestinationInfoModifier: ViewModifier {

    let title: String
    let image: Image

    func body(content: Content) -> some View {
        content
            .containerValue(\.title, title)
            .containerValue(\.icon, image)
    }
}

@available(iOS 18.0, *)
extension View {
    public func destinationInfo(_ title: String, image: Image = Image(systemName: "star")) -> some View {
        modifier(DestinationInfoModifier(title: title, image: image))
    }

    public func destinationInfo(_ title: String, icon systemIcon: String) -> some View {
        modifier(DestinationInfoModifier(title: title, image: Image(systemName: systemIcon)))
    }
}

// Create container values to use in the navigation links.
@available(iOS 18.0, *)
extension ContainerValues {
    @Entry var title: String = "Default value"
    @Entry var icon: Image = Image(systemName: "star")
}
