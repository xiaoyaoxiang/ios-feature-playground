//
//  AuthManager.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/13.
//

import SwiftUI
import Combine
import Foundation

@MainActor
class AuthManager: ObservableObject {

    static let shared = AuthManager()

    @Published var isLoggedIn = false
    @Published var accessToken: String?

    private init() {
        loadToken()
    }

    // 登录成功保存
    func saveToken(_ auth: AuthResponse) {
        accessToken = auth.accessToken
        isLoggedIn = true

        UserDefaults.standard.set(auth.accessToken, forKey: "access_token")

        let expireDate = Date().addingTimeInterval(TimeInterval(auth.expiresIn))
        UserDefaults.standard.set(expireDate, forKey: "expire_date")
    }

    // App启动时调用
    func loadToken() {
        guard
            let token = UserDefaults.standard.string(forKey: "access_token"),
            let expire = UserDefaults.standard.object(forKey: "expire_date") as? Date
        else {
            logout()
            return
        }

        if Date() > expire {
            logout()
            return
        }

        accessToken = token
        isLoggedIn = true
    }

    func logout() {
        accessToken = nil
        isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "access_token")
        UserDefaults.standard.removeObject(forKey: "expire_date")
    }
}
