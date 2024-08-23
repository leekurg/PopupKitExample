//
//  PopupKitAppDelegate.swift
//  PopupKitExample
//
//  Created by Илья Аникин on 23.08.2024.
//

import UIKit

class PopupKitAppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = PopupKitSceneDelegate.self
        return sceneConfig
    }
}
