//
//  FeedItem.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

struct FeedItem: Codable, Identifiable {
    let id: String
    let coverURL: String  // 使用驼峰命名法
    let title: String
    var likeCount: Int
    var favoriteCount: Int
    var commentCount: Int
    var isLiked: Bool
    var isFavorited: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case coverURL = "cover_url"  // 映射 JSON 字段名
        case title
        case likeCount = "like_count"
        case favoriteCount = "favorite_count"
        case commentCount = "comment_count"
        case isLiked = "is_liked"
        case isFavorited = "is_favorited"
    }
}
