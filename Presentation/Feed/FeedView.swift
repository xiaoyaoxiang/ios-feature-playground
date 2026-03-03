//
//  FeedView.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import SwiftUI

struct FeedView: View {

    @StateObject private var vm = FeedViewModel()

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {

            ScrollView {

                LazyVGrid(columns: columns, spacing: 12) {

                    ForEach($vm.items) { $item in

                        NavigationLink {
                            FeedDetailView(item: item)
                        } label: {
                            FeedCardView(item: $item)
                        }
                        .buttonStyle(.plain)
                        .onAppear {
                            Task {
                                await vm.loadMoreIfNeeded(current: item)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Feed")
            .task {
                // 首次加载
                if vm.items.isEmpty {
                    await vm.loadData()
                }
            }
            .refreshable {
                await vm.refresh()
            }
        }
    }
}

