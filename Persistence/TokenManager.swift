//
//  TokenManager.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import Foundation

final class TokenManager {

    static let shared = TokenManager()

    private init() {}

    private let tokenKey = "app.auth.token"

    // MARK: - 保存 Token
    func save(token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }

    // MARK: - 获取 Token
    var token: String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }

    // MARK: - 删除 Token
    func clear() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }

    // MARK: - 是否登录
    var isLoggedIn: Bool {
        return token != nil
    }
}
