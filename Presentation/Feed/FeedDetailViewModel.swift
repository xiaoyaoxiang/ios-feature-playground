//
//  FeedDetailViewModel.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import Foundation
import Combine

@MainActor
final class FeedDetailViewModel: ObservableObject {

    @Published var comments: [Comment] = []

    private let service = FeedService()

    func loadComments(feedId: String) async {
        do {
            print("加载评论")
            comments = try await service.fetchComments(id: feedId)
        } catch {
            print("加载评论失败:", error)
        }
    }

    func sendComment(feedId: String, content: String) async {
        do {
            try await service.postComment(
                id: feedId,
                content: content
            )

            // 发送成功后刷新评论
            await loadComments(feedId: feedId)

        } catch {
            print("发送评论失败:", error)
        }
    }
}
