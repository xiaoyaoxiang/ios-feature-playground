//
//  FeedViewModel.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import Foundation
import Combine

@MainActor
final class FeedViewModel: ObservableObject {

    @Published var items: [FeedItem] = []

    private let service = FeedService()
    private var page = 1
    private var isLoading = false

    // 首次加载
    func loadData() async {
        guard !isLoading else { return }
        isLoading = true

        do {
            print("开始加载数据")
            items = try await service.fetchFeed(page: 1)
            page = 1
            print("加载完成")
        } catch {
            print("加载失败:", error)
        }

        isLoading = false
    }

    // 下拉刷新
    func refresh() async {
        page = 1
        await loadData()
    }

    // 上拉加载更多
    func loadMoreIfNeeded(current item: FeedItem) async {
        guard let last = items.last else { return }
        guard last.id == item.id else { return }
        guard !isLoading else { return }

        isLoading = true
        page += 1

        do {
            let more = try await service.fetchFeed(page: page)
            items.append(contentsOf: more)
        } catch {
            print("加载更多失败:", error)
        }

        isLoading = false
    }
}
