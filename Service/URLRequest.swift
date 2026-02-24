//
//  Auth.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/13.
//

import Foundation

extension URLRequest {

    mutating func addAuthHeader() {
        if let token = AuthManager.shared.accessToken {
            setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
