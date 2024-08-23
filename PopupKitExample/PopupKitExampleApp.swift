//
//  PopupKitExampleApp.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import SwiftUI

@main
struct PopupKitExampleApp: App {
    @UIApplicationDelegateAdaptor var adaptor: PopupKitAppDelegate

    var body: some Scene {
        WindowGroup {
            MainSceneView()
        }
    }
}
