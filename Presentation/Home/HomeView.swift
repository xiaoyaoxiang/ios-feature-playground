//
//  HomeView.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//
import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    
    @State private var items = [
        SnapItem(id:UUID(), imagePath:"", text: "第一条记录", date: Date()),
        SnapItem(id:UUID(), imagePath:"", text: "第二条记录", date: Date())
      ]

    var body: some View {
           NavigationStack { // iOS 16+
               List(items) { item in
                   // NavigationLink 自动 push 到 DetailView
                   NavigationLink(destination: DetailView(item: item)) {
                       VStack(alignment: .leading) {
                           Text(item.text)
                               .font(.headline)
                           Text(item.date.formatted())
                               .font(.caption)
                               .foregroundColor(.gray)
                       }
                   }
               }
               .navigationTitle("Home")
           }
       }
}
