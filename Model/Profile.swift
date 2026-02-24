//
//  Profile.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/12.
//

import Foundation

struct ProfileResponse: Codable {
    let data: Profile
}

struct Profile: Codable {
    let id: Int
    let avatar: String
    let bg: String
    let nickname: String
    let followCount: Int
    let favoriteCount: Int
    let likeCount: Int
}
