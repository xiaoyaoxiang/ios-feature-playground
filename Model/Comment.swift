//
//  Comment.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import Foundation

struct Comment: Identifiable, Codable {
    let id: String
    let userName: String
    let content: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userName = "userName"
        case content
        case createdAt = "createdAt"
    }
}
