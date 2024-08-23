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
        }
    }
}

extension ContentView {
    enum Tab {
        case notification
        case fullscreen
    }
}

#Preview {
    ContentView()
        .debugPreviewFullscreenEnv()
        .debugPreviewNotificationEnv()
}
