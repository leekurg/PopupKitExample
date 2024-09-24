//
//  ContentView.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import SwiftUI
import PopupKit

struct ContentView: View {
    @State var selectedTab: Tab = .notification
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NotificationTest()
                .tabItem {
                    Label("Notification", systemImage: "bell")
                }
                .tag(Tab.notification)
            
            FullscreenTest()
                .tabItem {
                    Label("Fullscreen", systemImage: "rectangle.portrait.inset.filled")
                }
                .tag(Tab.fullscreen)
            
            CoverTest()
                .tabItem {
                    Label("Cover", systemImage: "rectangle.portrait.bottomhalf.inset.filled")
                }
                .tag(Tab.cover)
            
            ConfirmTest()
                .tabItem {
                    Label("Confirm", systemImage: "rectangle.grid.1x2.fill")
                }
                .tag(Tab.confirm)
        }
    }
}

extension ContentView {
    enum Tab {
        case notification
        case fullscreen
        case cover
        case confirm
    }
}

#Preview {
    ContentView()
        .previewPopupKit(ignoresSafeAreaEdges: .bottom)
}
