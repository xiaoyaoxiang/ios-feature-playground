//
//  FeedDetailView.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import SwiftUI

struct FeedDetailView: View {

    let item: FeedItem   // 详情页只展示，不用 Binding

    @StateObject private var vm = FeedDetailViewModel()

    @State private var commentText = ""

    var body: some View {
        ScrollView {

            VStack(alignment: .leading, spacing: 16) {

                // 封面图
                AsyncImage(url: URL(string: item.coverURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 250)
                .clipped()

                // 标题
                Text(item.title)
                    .font(.title2)
                    .bold()

                // 数据统计
                HStack(spacing: 16) {
                    Label("\(item.likeCount)", systemImage: "heart")
                    Label("\(item.favoriteCount)", systemImage: "star")
                    Label("\(item.commentCount)", systemImage: "bubble.right")
                }
                .foregroundColor(.gray)
                .font(.subheadline)

                Divider()

                // 评论标题
                Text("评论")
                    .font(.headline)

                // 评论列表
                ForEach(vm.comments) { comment in
                    VStack(alignment: .leading, spacing: 4) {

                        Text(comment.userName)
                            .font(.subheadline)
                            .bold()

                        Text(comment.content)

                        Text(comment.createdAt)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 6)

                    Divider()
                }
            }
            .padding()
        }
        .navigationTitle("详情")
        .navigationBarTitleDisplayMode(.inline)
        .safeAreaInset(edge: .bottom) {
            commentInputBar
        }
        .task {
            await vm.loadComments(feedId: item.id)
        }
        .refreshable {
            await vm.loadComments(feedId: item.id)
        }
    }

    // 底部评论输入栏
    private var commentInputBar: some View {
        HStack {
            TextField("写评论...", text: $commentText)
                .textFieldStyle(.roundedBorder)

            Button("发送") {
                Task {
                    await vm.sendComment(
                        feedId: item.id,
                        content: commentText
                    )
                    commentText = ""
                }
            }
            .disabled(commentText.isEmpty)
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}
