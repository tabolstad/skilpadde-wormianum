//
//  ContainersView.swift
//  Wormianum
//
//  Created by Timothy Bolstad on 10/21/24.
//

import SwiftUI

/*
 Demonstrates usage of SwiftUI container views.

 References:
 WWDC24 - Demystify SwiftUI container
 https://developer.apple.com/videos/play/wwdc2024/10146/
 Paul Hudson
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-position-and-style-subviews-that-come-from-a-different-view
*/

struct ContainersView: View {

    @State var isOn = true

    var body: some View {
        NavigationList {
            Text("containers")
                .destinationInfo("Containers", icon: "person")
        }
    }
}

#Preview {
    ContainersView()
}
