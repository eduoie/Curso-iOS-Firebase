//
//  Curso_iOS_FirebaseApp.swift
//  Curso iOS Firebase
//
//  Created by Equipo 2 on 2/3/26.
//

import FirebaseCore
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        print("🔥 Firebase configurado correctamente!")
        
        return true
    }
}

@main
struct Curso_iOS_FirebaseApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
