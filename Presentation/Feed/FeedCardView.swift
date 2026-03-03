//
//  FeedCardVie.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import SwiftUI

struct FeedCardView: View {

    @Binding var item: FeedItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // 图片（以后可替换视频）
            AsyncImage(url: URL(string: item.coverURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(height: 180)
            .clipped()
            .cornerRadius(12)

            Text(item.title)
                .font(.subheadline)
                .lineLimit(2)

            HStack(spacing: 16) {

                Button {
                    toggleLike()
                } label: {
                    HStack {
                        Image(systemName: item.isLiked ? "heart.fill" : "heart")
                        Text("\(item.likeCount)")
                    }
                }

                Button {
                    toggleFavorite()
                } label: {
                    HStack {
                        Image(systemName: item.isFavorited ? "star.fill" : "star")
                        Text("\(item.favoriteCount)")
                    }
                }

                Spacer()

                HStack {
                    Image(systemName: "message")
                    Text("\(item.commentCount)")
                }
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
    }

    func toggleLike() {
        item.isLiked.toggle()
        item.likeCount += item.isLiked ? 1 : -1

        // 这里调接口
    }

    func toggleFavorite() {
        item.isFavorited.toggle()
        item.favoriteCount += item.isFavorited ? 1 : -1

        // 这里调接口
    }
}
