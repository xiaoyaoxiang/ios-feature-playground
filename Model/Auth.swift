//
//  Auth.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/13.
//

struct AuthResponse: Codable {
    let accessToken: String
    let expiresIn: Int

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
}

