//
//  DetailView.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//

import SwiftUI

struct DetailView: View {

    let item: SnapItem

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(item.text)
                .font(.title)
            Text(item.date.formatted())
                .font(.caption)
                .foregroundColor(.gray)
            // 如果想显示图片，后面加 Image(uiImage: ...)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: SnapItem(id: UUID(), imagePath: "", text: "测试", date: .now))
    }
}

