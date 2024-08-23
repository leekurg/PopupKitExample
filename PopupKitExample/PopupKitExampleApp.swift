//
//  PopupKitExampleApp.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import SwiftUI

@main
struct PopupKitExampleApp: App {
    @UIApplicationDelegateAdaptor var adaptor: MyAppDelegate

    var body: some Scene {
        WindowGroup {
            MainSceneView()
        }
    }
}
