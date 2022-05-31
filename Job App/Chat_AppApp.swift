//
//  Chat_AppApp.swift
//  Chat App
//
//  Created by Pasha Panin on 10/31/21.
//

import SwiftUI
import Firebase
import FirebaseCore
@main
struct Chat_AppApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .accentColor(.black)
        }
    }
}
