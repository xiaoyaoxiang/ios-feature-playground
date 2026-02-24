//
//  SnapNoteApp.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//

import SwiftUI

@main
struct SnapNoteApp: App {

    @StateObject var auth = AuthManager.shared

    var body: some Scene {
        WindowGroup {
            if auth.isLoggedIn {
                MainTabView()
            } else {
                LoginView()
            }
        }
    }
}

