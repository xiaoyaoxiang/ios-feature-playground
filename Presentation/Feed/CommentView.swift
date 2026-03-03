//
//  CommentView.swift
//  ios-feature-playground
//
//  Created by Haixiang Wang on 2026/3/3.
//

import SwiftUI

struct CommentView: View {

    let itemId: String
    @State private var comments: [Comment] = []

    var body: some View {
        VStack {

            List(comments) { comment in
                VStack(alignment: .leading) {
                    Text(comment.userName)
                        .font(.headline)
                    Text(comment.content)
                }
            }

            HStack {
                TextField("写评论...", text: .constant(""))
                Button("发送") {
                    // 调接口
                }
            }
            .padding()
        }
        .navigationTitle("评论")
    }
}
