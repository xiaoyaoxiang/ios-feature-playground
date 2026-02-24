//
//  ProfileView.swift
//  SnapNote
//
//  Created by Haixiang Wang on 2026/2/12.
//

import SwiftUI

struct ProfileView: View {

    @StateObject var vm = ProfileViewModel()

    var body: some View {
        NavigationView {

            ScrollView {
                VStack(spacing: 20) {

                    // 头像+昵称+背景
                    ZStack {
                        if let profile = vm.profile,
                               let bgURL = URL(string: profile.bg) {
                                AsyncImage(url: bgURL) { phase in
                                    switch phase {
                                    case .empty:
                                        Color.gray.opacity(0.1) // 占位色
                                    case .success(let bgimage):
                                        bgimage
                                            .resizable()
                                            .scaledToFill()
                                    case .failure:
                                        Color.gray.opacity(0.1) // 请求失败显示占位
                                    @unknown default:
                                        Color.gray.opacity(0.1)
                                    }
                                }
                                .frame(height: 200)
                                .clipped()
                            } else {
                                // profile 还没加载出来时显示占位
                                Color.gray.opacity(0.1)
                                    .frame(height: 200)
                            }
                        // 头像 + 昵称
                        if let profile = vm.profile {
                            VStack(spacing: 10) {
                                AsyncImage(url: URL(string: profile.avatar)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image.resizable()
                                    case .failure:
                                        Image("default_avatar") // 本地占位图
                                            .resizable()
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))

                                Text(profile.nickname)
                                    .font(.title2)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                            // 保证头像 + 昵称在 ZStack 中垂直居中
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .frame(height: 200)

                           // 统计信息
                    if let profile = vm.profile {
                        HStack(spacing: 40) {
                            StatView(title: "关注", value: profile.followCount)
                            StatView(title: "收藏", value: profile.favoriteCount)
                            StatView(title: "喜欢", value: profile.likeCount)
                        }.padding(.horizontal)
                    }
                           

                           // 菜单列表
                           VStack(spacing: 0) {
                               MenuItem(icon: "cart.fill", title: "我的订单")
                               Divider()
                               MenuItem(icon: "envelope.fill", title: "我的消息")
                               Divider()
                               MenuItem(icon: "gearshape.fill", title: "设置")
                           }
                           .background(Color.white)
                           .cornerRadius(10)
                           .padding(.horizontal)
                           .shadow(radius: 2)
                    
                    Spacer() // ⭐ 占据剩余空间，把按钮推到内容区域底部，但不挡 Tab

                    // 退出按钮
                    Button {
                        AuthManager.shared.logout()
                    } label: {
                        Text("退出登录")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                       }
                       .padding(.vertical)
                   }
                   .refreshable {
                       await vm.fetchProfile()
                   }

            .navigationTitle("我的")
            .task {
                await vm.fetchProfile()
            }
        }
    }
}


struct StatView: View {
    let title: String
    let value: Int

    var body: some View {
        VStack {
            Text("\(value)")
                .font(.title2)
                .bold()

            Text(title)
                .foregroundColor(.gray)
        }
    }
}

struct MenuItem: View {
    let icon: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
    }
}

