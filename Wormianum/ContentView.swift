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
            .destinationInfo("Animation")
        ContainersView()
            .destinationInfo("Containers")
    }
}

#Preview {
    ContentView()
}
