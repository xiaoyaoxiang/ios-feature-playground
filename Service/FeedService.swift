//
//  FeedService.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import Foundation

final class FeedService {

    // 获取 Feed 数据接口
    func fetchFeed(page: Int) async throws -> [FeedItem] {
        try await APIClient.shared.request(
            endpoint: Endpoint(path: "/feed?page=\(page)", method: "GET", body: nil),
            type: [FeedItem].self
        )
    }

    // 点赞接口
    func toggleLike(id: String) async throws {
        _ = try await APIClient.shared.request(
            endpoint: Endpoint(path: "/like/\(id)", method: "POST", body: nil),
            type: EmptyResponse.self
        )
    }

    // 收藏接口
    func toggleFavorite(id: String) async throws {
        _ = try await APIClient.shared.request(
            endpoint: Endpoint(path: "/favorite/\(id)", method: "POST", body: nil),
            type: EmptyResponse.self
        )
    }

    // 发送评论接口
    func postComment(id: String, content: String) async throws {
        let body = ["comment": content]
        _ = try await APIClient.shared.request(
            endpoint: Endpoint(path: "/comment/\(id)", method: "POST", body: try? JSONSerialization.data(withJSONObject: body)),
            type: EmptyResponse.self
        )
    }
    
    // 获取评论列表
    func fetchComments(id: String) async throws -> [Comment] {
        let endpoint = Endpoint(
            path: "/feeds/\(id)/comments",
            method: "GET",
            body: nil  // 无需请求体
        )
        
        return try await APIClient.shared.request(
            endpoint: endpoint,
            type: [Comment].self
        )
    }
}
