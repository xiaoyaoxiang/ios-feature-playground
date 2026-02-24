//
//  SnapItem.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//

import Foundation

struct SnapItem: Identifiable, Codable {
    let id: UUID
    let imagePath: String
    let text: String
    let date: Date
}

