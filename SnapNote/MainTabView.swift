//
//  MainTabView.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/10.
//

import SwiftUI

struct MainTabView: View {

    var body: some View {
        TabView {
            HomeView() // 首页
                .tabItem {
                    Image(systemName: "house")
                    Text("首页")
                }

            ProfileView()
                .tabItem {
                    Label("我的", systemImage: "person")
                }
        }
    }
}
