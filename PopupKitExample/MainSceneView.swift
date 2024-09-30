//
//  MainSceneView.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import PopupKit
import SwiftUI

// MARK: -  Passthrough UIWindow pattern
//struct MainSceneView: View {
//    @EnvironmentObject var sceneDelegate: MySceneDelegate
//
//    var body: some View {
//        ContentView()
//            .environmentObject(sceneDelegate.coverPresenter)
//            .environmentObject(sceneDelegate.fullscreenPresenter)
//            .environmentObject(sceneDelegate.notificationPresenter)
//    }
//}

// MARK: - vanilla SwiftUI view hierarchy pattern
struct MainSceneView: View {
    @StateObject private var coverPresenter = CoverPresenter()
    @StateObject private var fullscreenPresenter = FullscreenPresenter()
    @StateObject private var notificationPresenter = NotificationPresenter()

    var body: some View {
        ContentView()
//            .coverRoot()
//            .ignoresSafeArea(.all, edges: [.all])
            .fullscreenRoot()
//            .notificationRoot()
            .environmentObject(coverPresenter)
            .environmentObject(fullscreenPresenter)
            .environmentObject(notificationPresenter)
    }
}
