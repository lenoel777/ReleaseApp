//
//  ReleaseAppApp.swift
//  ReleaseApp
//
//  Created by Glenn Leonali on 27/05/24.
//

import SwiftUI

@main
struct ReleaseAppApp: App {
    init() {
            // Force Dark Mode
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                windowScene.windows.forEach { window in
                    window.overrideUserInterfaceStyle = .dark
                }
            }
        }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .preferredColorScheme(.dark)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
