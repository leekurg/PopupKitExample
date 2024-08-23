//
//  MainSceneView.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import SwiftUI

struct MainSceneView: View {
    @EnvironmentObject var sceneDelegate: PopupKitSceneDelegate

    var body: some View {
        ContentView()
            .environmentObject(sceneDelegate.notificationPresenter)
    }
}
